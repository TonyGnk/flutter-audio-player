import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musicgnk/player.dart';
import 'main.dart';

class TracksList extends StatelessWidget {
  final Player playerz;

  const TracksList({super.key, required this.playerz});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final audioFilesAsync = ref.watch(audioFilesProvider);
        return audioFilesAsync.when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
          data: (audioFiles) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: audioFiles.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    playerz.setLastSong(audioFiles[index].path);
                  }
                  return Consumer(
                    builder: (_, WidgetRef ref, __) {
                      return ElevatedButton(
                        onPressed: () {
                          playerz.play(audioFiles[index].path);
                          print("Pressed");
                          ref.read(playingStateProvider.notifier).state = true;
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                          foregroundColor: Colors.white,
                          shadowColor: const Color.fromARGB(0, 255, 255, 255),
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          elevation: 0,
                        ),
                        child: Row(
                          children: [
                            //give the context to the widget
                            musicIcon(context),
                            const SizedBox(width: 1),
                            Expanded(
                              child: Container(
                                height: 70,
                                padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                                decoration: index != audioFiles.length - 1
                                    ? const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            width: 1.0,
                                            color: Color.fromARGB(
                                                255, 232, 232, 232),
                                          ),
                                        ),
                                      )
                                    : null,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      removeExtension(audioFiles[index]
                                          .uri
                                          .pathSegments
                                          .last),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                    ),
                                    Text(
                                      "Άγνωστο",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary
                                            .withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget musicIcon(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      padding: const EdgeInsets.all(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onError,
          borderRadius: const BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/music.svg',
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }

  String removeExtension(String str) {
    return str.substring(0, str.length - 4);
  }
}