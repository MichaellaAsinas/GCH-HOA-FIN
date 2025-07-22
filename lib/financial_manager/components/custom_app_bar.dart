import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle titleStyle;
  final bool showBackButton;
  final bool showSearch;
  final TextEditingController? searchController;
  final GestureTapDownCallback? onFilterTapDown;
  final PreferredSizeWidget? bottom;
  final Color backgroundColor;
  final double toolbarHeight;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.titleStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    this.showBackButton = false,
    this.showSearch = false,
    this.searchController,
    this.onFilterTapDown,
    this.bottom,
    this.backgroundColor = const Color.fromARGB(255, 0, 115, 173),
    this.toolbarHeight = kToolbarHeight,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(
        toolbarHeight + (bottom?.preferredSize.height ?? 0),
      );

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  void _logout() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 12),
              Text("Logging out..."),
            ],
          ),
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      Navigator.of(context).pop(); // Close the dialog
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  void _handleMenuTap(BuildContext context, TapDownDetails details) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy + 12,
        overlay.size.width - details.globalPosition.dx,
        0,
      ),
      items: [
        PopupMenuItem(
          enabled: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/pic.jpg'),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Elijah Esguerra", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Financial Manager", style: TextStyle(fontSize: 12, color: Colors.black)),
                    ],
                  ),
                ],
              ),
              const Divider(thickness: 1, height: 20),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'profile',
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text('View Profile'),
          ),
        ),
        const PopupMenuItem(
          value: 'logout',
          child: ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          ),
        ),
      ],
      elevation: 8,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    ).then((value) {
      if (value == 'profile') {
        Navigator.pushNamed(context, '/fm_profile');
      } else if (value == 'logout') {
        _logout(); // Show loading when logging out
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: widget.toolbarHeight,
      backgroundColor: widget.backgroundColor,
      leading: widget.showBackButton
          ? Tooltip(
              message: 'Back',
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          : null,
      title: widget.showSearch && widget.searchController != null
          ? TextField(
              controller: widget.searchController,
              decoration: const InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
              ),
            )
          : Text(widget.title, style: widget.titleStyle),
      actions: [
        if (widget.onFilterTapDown != null)
          GestureDetector(
            onTapDown: widget.onFilterTapDown,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.filter_list, color: Colors.white),
            ),
          ),
        GestureDetector(
          onTapDown: (details) => _handleMenuTap(context, details),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/pic.jpg'),
            ),
          ),
        ),
      ],
      bottom: widget.bottom,
    );
  }
}
