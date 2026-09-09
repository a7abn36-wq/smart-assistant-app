// ═══════════════════════════════════════════════════════════════════════════════
// شات أوفلاين — Offline Chat Screen
// شات بير-تو-بير (Peer-to-Peer) محاكي باستخدام WiFi Direct
// الرسائل بتتحفظ محلياً بـ SharedPreferences
// ═══════════════════════════════════════════════════════════════════════════════

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';

/// نموذج الرسالة
class ChatMessage {
  final String id;
  final String text;
  final String sender; // 'me' أو اسم الجهاز
  final DateTime timestamp;
  final bool isMine;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
    required this.isMine,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'sender': sender,
        'timestamp': timestamp.toIso8601String(),
        'isMine': isMine,
      };

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        id: json['id'],
        text: json['text'],
        sender: json['sender'],
        timestamp: DateTime.parse(json['timestamp']),
        isMine: json['isMine'],
      );
}

/// نموذج الجهاز المكتشف
class DiscoveredPeer {
  final String id;
  final String name;
  final String role; // دور الجهاز
  bool isConnected;

  DiscoveredPeer({
    required this.id,
    required this.name,
    required this.role,
    this.isConnected = false,
  });
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _msgController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _isDiscovering = false;
  bool _isConnected = false;
  String _connectedPeer = '';
  List<DiscoveredPeer> _discoveredPeers = [];
  List<ChatMessage> _messages = [];

  // الأجهزة المحاكية (Mock Peers) — بتحاكي اكتشاف WiFi Direct
  static const List<Map<String, String>> _mockDevices = [
    {'id': 'peer-ahmed', 'name': 'أحمد - موبايل الموقع', 'role': 'مهندس موقع'},
    {'id': 'peer-mahmoud', 'name': 'محمود - تابلت الصيانة', 'role': 'فني صيانة'},
    {'id': 'peer-hassan', 'name': 'حسن - لابтоп المحطة', 'role': 'مشرف'},
    {'id': 'peer-said', 'name': 'سعيد - موبايل وردية ب', 'role': 'مشغل'},
  ];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  void dispose() {
    _msgController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// تحميل الرسائل من SharedPreferences
  Future<void> _loadMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getStringList('offline_chat_messages') ?? [];
      setState(() {
        _messages = saved.map((s) => ChatMessage.fromJson(jsonDecode(s))).toList();
      });
    } catch (_) {
      // لو في مشكلة نبدأ فاضية
    }
  }

  /// حفظ الرسائل في SharedPreferences
  Future<void> _saveMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = _messages.map((m) => jsonEncode(m.toJson())).toList();
      await prefs.setStringList('offline_chat_messages', encoded);
    } catch (_) {}
  }

  /// محاكاة اكتشاف الأجهزة القريبة
  Future<void> _discoverPeers() async {
    setState(() => _isDiscovering = true);

    // محاكاة تأخير الاكتشاف
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _discoveredPeers = _mockDevices.map((d) => DiscoveredPeer(
            id: d['id']!,
            name: d['name']!,
            role: d['role']!,
          )).toList();
      _isDiscovering = false;
    });
  }

  /// الاتصال بجهاز
  void _connectToPeer(DiscoveredPeer peer) {
    setState(() {
      for (final p in _discoveredPeers) {
        p.isConnected = false;
      }
      peer.isConnected = true;
      _isConnected = true;
      _connectedPeer = peer.name;
    });

    // رسالة نظام
    _addSystemMessage('اتصلت بـ ${{peer.name}} — اقدرك تبعت واستقبل رسايل أوفلاين!');
  }

  /// قطع الاتصال
  void _disconnect() {
    setState(() {
      for (final p in _discoveredPeers) {
        p.isConnected = false;
      }
      _isConnected = false;
      _connectedPeer = '';
    });
    _addSystemMessage('اتقطع الاتصال — اكتشف تاني لو عايز تتصل');
  }

  /// إضافة رسالة نظام
  void _addSystemMessage(String text) {
    final msg = ChatMessage(
      id: 'sys-${DateTime.now().millisecondsSinceEpoch}',
      text: text,
      sender: 'النظام',
      timestamp: DateTime.now(),
      isMine: false,
    );
    setState(() => _messages.add(msg));
    _saveMessages();
  }

  /// إرسال رسالة
  void _sendMessage() {
    final text = _msgController.text.trim();
    if (text.isEmpty) return;

    final msg = ChatMessage(
      id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
      text: text,
      sender: 'أنا',
      timestamp: DateTime.now(),
      isMine: true,
    );

    setState(() {
      _messages.add(msg);
      _msgController.clear();
    });
    _saveMessages();

    // محاكاة رد من الطرف التاني
    if (_isConnected) {
      Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
        if (!mounted) return;
        final reply = ChatMessage(
          id: 'reply-${DateTime.now().millisecondsSinceEpoch}',
          text: _generateAutoReply(text),
          sender: _connectedPeer,
          timestamp: DateTime.now(),
          isMine: false,
        );
        setState(() => _messages.add(reply));
        _saveMessages();
        _scrollToBottom();
      });
    }

    _scrollToBottom();
  }

  /// محاكاة رد تلقائي
  String _generateAutoReply(String incoming) {
    final replies = [
      'تمام، فهمت — هاعمل الزلق ده دلوقتي',
      'أوكي، أنا في الطريق — 5 دقايق وأنا معاك',
      'مشكلة فين بالزبط؟ ابعتلي صورة لو تقدر',
      'الشيلر شغال من الصبح — مفيش مشاكل الحمد لله',
      'نظفت الـ Strainer (الفلتر) النهارده — الميه ماشية حلو',
      'أمبارح عملنا الـ PM (صيانة دورية) على المضخة الكبيرة — كل حاجة أوكي',
      'لو سمحت سجل العطل في التطبيق عشان المدير يشوفه',
      'الـ Controller (شاشة التحكم) طلع Error (خطأ) الليلة — لازم نشوفه',
    ];
    return replies[DateTime.now().millisecond % replies.length];
  }

  /// السكرول لآخر رسالة
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(
          backgroundColor: AppTheme.darkBg,
          title: Text(
            'شات أوفلاين',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.greenNeon,
              shadows: [Shadow(color: AppTheme.greenNeon, blurRadius: 10)],
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppTheme.cyanGlow),
          actions: [
            if (_isConnected)
              IconButton(
                icon: const Icon(Icons.link_off, color: AppTheme.fireRed),
                tooltip: 'اقطع الاتصال',
                onPressed: _disconnect,
              ),
          ],
        ),
        body: Column(
          children: [
            // ── قسم الاكتشاف والاتصال ──
            _buildDiscoverySection(),
            const Divider(color: AppTheme.subtleBorder, height: 1),

            // ── حالة الاتصال ──
            if (_isConnected)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                color: AppTheme.greenNeon.withOpacity(0.08),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.greenNeon,
                        boxShadow: [BoxShadow(color: AppTheme.greenNeon, blurRadius: 6)],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'متصل بـ $_connectedPeer',
                        style: const TextStyle(color: AppTheme.greenNeon, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Text(
                      'WiFi Direct (مباشر)',
                      style: TextStyle(color: AppTheme.ice, fontSize: 10),
                      textDirection: TextDirection.ltr,
                    ),
                  ],
                ),
              ),

            // ── الرسايل ──
            Expanded(
              child: _messages.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.chat_bubble_outline, size: 48, color: AppTheme.grayText.withOpacity(0.5)),
                          const SizedBox(height: 12),
                          const Text(
                            'مفيش رسايل لسه',
                            style: TextStyle(color: AppTheme.grayText, fontSize: 16),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'اكتشف جهاز قريب وابعت رسالة!',
                            style: TextStyle(color: AppTheme.ice, fontSize: 13),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(12),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) => _buildMessageBubble(_messages[index]),
                    ),
            ),

            // ── حقل الإرسال ──
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.cardBg,
                border: Border(top: BorderSide(color: AppTheme.subtleBorder)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.darkBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppTheme.cyanGlow.withOpacity(0.3)),
                      ),
                      child: TextField(
                        controller: _msgController,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          hintText: 'اكتب رسالتك...',
                          hintStyle: const TextStyle(color: AppTheme.grayText, fontSize: 13),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.greenNeon.withOpacity(0.2),
                      border: Border.all(color: AppTheme.greenNeon.withOpacity(0.4)),
                      boxShadow: [BoxShadow(color: AppTheme.greenNeon.withOpacity(0.15), blurRadius: 8)],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: AppTheme.greenNeon, size: 20),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// قسم الاكتشاف
  Widget _buildDiscoverySection() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 220),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        border: Border(bottom: BorderSide(color: AppTheme.subtleBorder)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'اكتشاف الأجهزة القريبة',
                style: TextStyle(
                  color: AppTheme.cyanGlow,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                '(WiFi Direct - واي فاي مباشر)',
                style: TextStyle(color: AppTheme.ice, fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // زر الاكتشاف
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isDiscovering ? null : _discoverPeers,
              icon: _isDiscovering
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppTheme.darkBg,
                      ),
                    )
                  : const Icon(Icons.wifi_tethering, size: 18),
              label: Text(
                _isDiscovering ? 'بيدور على أجهزة...' : 'اكتشف الأجهزة القريبة',
                style: const TextStyle(fontSize: 13),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.cyanGlow,
                foregroundColor: AppTheme.darkBg,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
          // قايمة الأجهزة المكتشفة
          if (_discoveredPeers.isNotEmpty) ...[
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _discoveredPeers.length,
                itemBuilder: (context, index) {
                  final peer = _discoveredPeers[index];
                  return GestureDetector(
                    onTap: () => _connectToPeer(peer),
                    child: Container(
                      width: 150,
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: peer.isConnected
                            ? AppTheme.greenNeon.withOpacity(0.1)
                            : AppTheme.darkBg,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: peer.isConnected
                              ? AppTheme.greenNeon.withOpacity(0.5)
                              : AppTheme.subtleBorder,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                peer.isConnected ? Icons.link : Icons.devices,
                                color: peer.isConnected ? AppTheme.greenNeon : AppTheme.ice,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  peer.name,
                                  style: TextStyle(
                                    color: peer.isConnected ? AppTheme.greenNeon : Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            peer.role,
                            style: const TextStyle(color: AppTheme.ice, fontSize: 9),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// فقاعة الرسالة
  Widget _buildMessageBubble(ChatMessage msg) {
    final isSystem = msg.sender == 'النظام';

    if (isSystem) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.cyanGlow.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.cyanGlow.withOpacity(0.2)),
            ),
            child: Text(
              msg.text,
              style: const TextStyle(color: AppTheme.ice, fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    final isMine = msg.isMine;
    final bubbleColor = isMine
        ? AppTheme.greenNeon.withOpacity(0.15)
        : AppTheme.cyanGlow.withOpacity(0.1);
    final borderColor = isMine
        ? AppTheme.greenNeon.withOpacity(0.3)
        : AppTheme.cyanGlow.withOpacity(0.2);
    final textColor = isMine ? Colors.white : Colors.white;
    final timeColor = AppTheme.grayText;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: isMine ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isMine) ...[
            Text(
              _formatTime(msg.timestamp),
              style: TextStyle(color: timeColor, fontSize: 9),
            ),
            const SizedBox(width: 4),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(14),
                  topRight: const Radius.circular(14),
                  bottomLeft: Radius.circular(isMine ? 2 : 14),
                  bottomRight: Radius.circular(isMine ? 14 : 2),
                ),
                border: Border.all(color: borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isMine)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Text(
                        msg.sender,
                        style: TextStyle(
                          color: AppTheme.cyanGlow,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  Text(
                    msg.text,
                    style: TextStyle(color: textColor, fontSize: 14, height: 1.4),
                  ),
                ],
              ),
            ),
          ),
          if (!isMine) ...[
            const SizedBox(width: 4),
            Text(
              _formatTime(msg.timestamp),
              style: TextStyle(color: timeColor, fontSize: 9),
            ),
          ],
        ],
      ),
    );
  }

  /// تنسيق الوقت
  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
