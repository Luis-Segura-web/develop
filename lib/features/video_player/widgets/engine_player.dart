import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

/// Widget que permite alternar entre ExoPlayer (video_player) y libVLC
class EnginePlayer extends StatefulWidget {
  final String url;
  const EnginePlayer({Key? key, required this.url}) : super(key: key);

  @override
  _EnginePlayerState createState() => _EnginePlayerState();
}

class _EnginePlayerState extends State<EnginePlayer> {
  bool _useVlc = false;
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  VlcPlayerController? _vlcController;

  @override
  void initState() {
    super.initState();
    _loadPreference();
  }

  Future<void> _loadPreference() async {
    final prefs = await SharedPreferences.getInstance();
    final useVlc = prefs.getBool('prefUseVlc') ?? false;
    setState(() {
      _useVlc = useVlc;
    });
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    await _disposeControllers();
    if (_useVlc) {
      _vlcController = VlcPlayerController.network(
        widget.url,
        hwAcc: HwAcc.FULL,
        options: VlcPlayerOptions(),
      );
      _vlcController!.initialize();
    } else {
      _videoController = VideoPlayerController.network(widget.url);
      await _videoController!.initialize();
      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        autoPlay: true,
        looping: false,
      );
    }
    setState(() {});
  }

  Future<void> _disposeControllers() async {
    await _chewieController?.dispose();
    await _videoController?.dispose();
    await _vlcController?.stopRendererScanning();
    await _vlcController?.dispose();
    _chewieController = null;
    _videoController = null;
    _vlcController = null;
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _toggleEngine() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('prefUseVlc', !_useVlc);
    setState(() {
      _useVlc = !_useVlc;
    });
    _initializePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Motor: ${_useVlc ? 'VLC' : 'Exo'}'),
            Switch(
              value: _useVlc,
              onChanged: (_) => _toggleEngine(),
            ),
          ],
        ),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _useVlc
                ? _buildVlcPlayer()
                : _buildChewiePlayer(),
          ),
        ),
      ],
    );
  }

  Widget _buildChewiePlayer() {
    if (_chewieController != null && _chewieController!.videoPlayerController.value.isInitialized) {
      return Chewie(controller: _chewieController!);
    }
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildVlcPlayer() {
    if (_vlcController != null) {
      return VlcPlayer(
        controller: _vlcController!,
        aspectRatio: 16 / 9,
        placeholder: const Center(child: CircularProgressIndicator()),
      );
    }
    return const Center(child: CircularProgressIndicator());
  }
}
