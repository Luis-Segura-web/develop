import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final Map<String, List<Map<String, dynamic>>> channelsByCategory;
  final String? expandedCategoryId;
  final Map<String, dynamic>? selectedChannel;
  final Function(String?) onCategoryExpanded;
  final Function(Map<String, dynamic>) onChannelSelected;

  const CategoryList({
    super.key,
    required this.categories,
    required this.channelsByCategory,
    required this.expandedCategoryId,
    required this.selectedChannel,
    required this.onCategoryExpanded,
    required this.onChannelSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final categoryId = category['category_id']?.toString();
          final categoryName = category['category_name'] ?? 'Categoría sin nombre';
          final channels = channelsByCategory[categoryId] ?? [];
          final isExpanded = expandedCategoryId == categoryId;

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                // Header de la categoría
                InkWell(
                  onTap: () => onCategoryExpanded(categoryId),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.folder,
                          color: Colors.grey[400],
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            categoryName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E88E5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${channels.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                  ),
                ),

                // Lista de canales (expandible)
                if (isExpanded) ...[
                  const Divider(
                    height: 1,
                    color: Colors.grey,
                    indent: 16,
                    endIndent: 16,
                  ),
                  ...channels.map((channel) => _buildChannelTile(context, channel)),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildChannelTile(BuildContext context, Map<String, dynamic> channel) {
    final isSelected = selectedChannel?['stream_id'] == channel['stream_id'];
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1E88E5).withOpacity(0.3) : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: isSelected ? Border.all(color: const Color(0xFF1E88E5), width: 1) : null,
      ),
      child: ListTile(
        dense: true,
        leading: Container(
          width: 50,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey[700],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: channel['stream_icon'] != null
                ? Image.network(
                    channel['stream_icon'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.tv,
                      color: Colors.white,
                      size: 20,
                    ),
                  )
                : const Icon(
                    Icons.tv,
                    color: Colors.white,
                    size: 20,
                  ),
          ),
        ),
        title: Text(
          channel['name'] ?? 'Canal sin nombre',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Ahora: Programación en vivo',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 11,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.8),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'EN VIVO',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.favorite_border,
            color: Colors.white,
            size: 22,
          ),
          onPressed: () {
            // TODO: Implementar favoritos
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Canal ${channel['name']} agregado a favoritos'),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 1),
              ),
            );
          },
          padding: const EdgeInsets.all(6),
          constraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
        ),
        onTap: () => onChannelSelected(channel),
      ),
    );
  }
}
