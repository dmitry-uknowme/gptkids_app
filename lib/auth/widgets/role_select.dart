import 'package:flutter/material.dart';
import 'package:gptkids_app/common/theme/theme.dart';

class RoleSelect extends StatelessWidget {
  final String selectedRoleName;
  final List<RoleOption> roles;
  final ValueChanged<String> onChanged;
  final bool selectHidden;
  final ValueChanged<bool> onChangedSelectHidden;

  const RoleSelect({
    super.key,
    required this.selectedRoleName,
    required this.roles,
    required this.onChanged,
    required this.selectHidden,
    required this.onChangedSelectHidden,
  });

  Widget _buildRoleSummary() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Выбрана роль: ${selectedRoleName}'),
        TextButton(
          onPressed: () => {onChangedSelectHidden(false)},
          child: const Text('Сменить роль'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(microseconds: 300),
      child:
          selectHidden
              ? _buildRoleSummary()
              : Row(
                children:
                    roles.map((option) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: RoleSelectCard(
                            selected: option.name == selectedRoleName,
                            name: option.name,
                            label: option.label,
                            icon: option.icon,
                            onTap: () => onChanged(option.name),
                          ),
                        ),
                      );
                    }).toList(),
              ),
    );
  }
}

class RoleOption {
  final String name;
  final String label;
  final IconData icon;

  RoleOption({required this.name, required this.label, required this.icon});
}

class RoleSelectCard extends StatelessWidget {
  final bool selected;
  final String name;
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const RoleSelectCard({
    super.key,
    required this.selected,
    required this.name,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1, // Квадрат
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withOpacity(0.1) : AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
            width: 1.5,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: selected ? AppColors.primary : AppColors.textPrimary,
                ),
                const SizedBox(height: 12),
                Text(
                  label,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
