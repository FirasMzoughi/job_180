import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class Message {
  final String text;
  final bool isSentByMe;
  Message({required this.text, required this.isSentByMe});
}

class _ChatPageState extends State<ChatPage> {
  // Exemple de messages pour le chat
  final List<Message> _messages = [
    Message(text: "Bonjour, je suis intéressé par cette offre.", isSentByMe: false),
    Message(text: "Merci pour votre intérêt ! Pouvez-vous m'envoyer votre CV ?", isSentByMe: true),
    Message(text: "Oui, je vous l'envoie dès maintenant.", isSentByMe: false),
  ];

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Méthode d'envoi de message
  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add(Message(text: text, isSentByMe: true));
      });
      _controller.clear();
      // Défilement automatique vers le dernier message
      Future.delayed(Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 50,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  // Widget pour la bulle d'un message
  Widget _buildMessageBubble(Message message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment:
            message.isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isSentByMe)
            CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              radius: 20,
              child: Icon(Icons.person, color: Colors.blue),
            ),
          if (!message.isSentByMe) SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isSentByMe ? Colors.blueAccent : Colors.grey.shade200,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: message.isSentByMe ? Radius.circular(18) : Radius.circular(0),
                  bottomRight: message.isSentByMe ? Radius.circular(0) : Radius.circular(18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                    color: message.isSentByMe ? Colors.white : Colors.black87,
                    fontSize: 15),
              ),
            ),
          ),
          if (message.isSentByMe) SizedBox(width: 8),
          if (message.isSentByMe)
            CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              radius: 20,
              child: Icon(Icons.person, color: Colors.blue),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fond de page avec un dégradé subtil pour une ambiance moderne
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar customisée avec bouton retour et icônes supplémentaires
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.blue, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        "Conversation",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Icône d'appel pour déclencher un appel vocal ou vidéo
                    IconButton(
                      icon: Icon(Icons.call, color: Colors.blue, size: 28),
                      onPressed: () {
                        // Ajoutez ici la logique pour un appel
                      },
                    ),
                  ],
                ),
              ),
              // Affichage des messages
              Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  itemCount: _messages.length,
                  separatorBuilder: (context, index) => SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return _buildMessageBubble(message);
                  },
                ),
              ),
              // Zone d'envoi de message avec champ textuel, bouton d'attachement et bouton d'envoi
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey.shade300, width: 0.5)),
                ),
                child: Row(
                  children: [
                    // Bouton d'attachement
                    IconButton(
                      icon: Icon(Icons.attach_file, color: Colors.grey.shade600),
                      onPressed: () {
                        // Implémentez ici la sélection de fichier ou d'image
                      },
                    ),
                    Expanded(
                      // Champ textuel avec fond gris clair et coins arrondis
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextField(
                          controller: _controller,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            hintText: "Votre message...",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    // Bouton d'envoi rond et coloré
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.send, color: Colors.white),
                        onPressed: _sendMessage,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
