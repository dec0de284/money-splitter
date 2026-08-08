import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/app_database.dart';
import '../../data/profile_repository.dart';

class ProfilesScreen extends StatelessWidget {
  const ProfilesScreen({super.key, required this.repository});

  final ProfileRepository repository;

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(locale: 'en_PH', symbol: '₱');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profiles'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context, -1),
            tooltip: 'Create profile',
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<List<Profile>>(
        stream: repository.watchProfiles(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Could not load profiles: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final profiles = snapshot.data!;
          if (profiles.isEmpty) {
            return const Center(child: Text('No saved profiles yet.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: profiles.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final profile = profiles[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                title: Text(profile.name),
                subtitle: Text(
                  '${profile.capitalName} · ${currency.format(profile.capitalMinorUnits / 100)}',
                ),
                onTap: () => Navigator.pop(context, profile.id),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => repository.setFavorite(
                        profile.id,
                        !profile.isFavorite,
                      ),
                      tooltip: profile.isFavorite
                          ? 'Remove as Favorite'
                          : 'Mark as Favorite',
                      icon: Icon(
                        profile.isFavorite ? Icons.star : Icons.star_border,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context, profile.id),
                      tooltip: 'Edit Profile',
                      icon: const Icon(Icons.edit_outlined),
                    ),
                    IconButton(
                      onPressed: () => _delete(context, profile),
                      tooltip: 'Delete Profile',
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _delete(BuildContext context, Profile profile) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete profile?'),
        content: Text('Delete “${profile.name}” and all of its splits?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true) await repository.deleteProfile(profile.id);
  }
}
