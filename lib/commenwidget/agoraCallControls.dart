import 'package:flutter/material.dart';

class AgoraCallControls extends StatelessWidget {
  final Function() onToggleMute;
  final bool isMuted ;
  final bool isSpeaker ;
  final bool isCameraOpen ;
  final Function()? onToggleCamera;
  final Function() onToggleSpeaker;
  final Function() onEndCall;

  AgoraCallControls({
    required this.onToggleMute,
    required this.isMuted,
    required this.isSpeaker,
    this.isCameraOpen = true,
    this.onToggleCamera,
    required this.onToggleSpeaker,
    required this.onEndCall,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildControlButton(
          icon: isMuted ? Icons.mic_off : Icons.mic,
          color: isMuted ? Colors.grey : Colors.green,
          onPressed: onToggleMute,
        ),
        if(onToggleCamera != null)
        _buildControlButton(
          icon: isCameraOpen ? Icons.videocam : Icons.videocam_off ,
          color: isCameraOpen ? Colors.green : Colors.grey ,
          onPressed: onToggleCamera!,
        ),
        _buildControlButton(
          icon: isSpeaker ? Icons.volume_up : Icons.volume_off,
          color: isSpeaker  ? Colors.grey : Colors.green,
          onPressed: onToggleSpeaker,
        ),
        _buildControlButton(
          icon: Icons.call_end,
          onPressed: onEndCall,
          color: Colors.red,
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required Function() onPressed,
    Color? color,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? Colors.green,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}
