import 'package:flutter/material.dart';

class ChannelSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSearchChanged;

  const ChannelSearchBar({
    super.key,
    required this.controller,
    required this.onSearchChanged,
  });

  @override
  State<ChannelSearchBar> createState() => _ChannelSearchBarState();
}

class _ChannelSearchBarState extends State<ChannelSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[700]!),
      ),
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onSearchChanged,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Buscar canales...',
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[400],
          ),
          suffixIcon: widget.controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.grey[400],
                  ),
                  onPressed: () {
                    widget.controller.clear();
                    widget.onSearchChanged('');
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
