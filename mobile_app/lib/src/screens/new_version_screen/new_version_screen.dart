import 'package:al_downloader/al_downloader.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';

import '../../data/models/models.dart';
import '../utils/constant.dart';
import '../utils/fetching_status.dart';

class NewVersionScreen extends StatefulWidget {
  const NewVersionScreen({
    Key? key,
    required this.activeVersion,
  }) : super(key: key);

  final AppVersionModel activeVersion;

  @override
  State<NewVersionScreen> createState() => _NewVersionScreenState();
}

class _NewVersionScreenState extends State<NewVersionScreen> {
  FetchingStatus _status = FetchingStatus.init;
  String errorMessage = "";

  double _progress = 0.00;
  Future<void> download(String url) async {
    setState(() {
      _status = FetchingStatus.loading;
    });

    await ALDownloader.download(url,
        downloaderHandlerInterface: ALDownloaderHandlerInterface(
            progressHandler: (progress) {
              setState(() {
                _progress = progress;
              });
            },
            succeededHandler: () {
              setState(() {
                _status = FetchingStatus.success;
              });
            },
            failedHandler: () {
              setState(() {
                _status = FetchingStatus.error;
                errorMessage = "Failed to download";
              });
            },
            pausedHandler: () {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New version available.",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 30.0),
                ),
                const Text(
                    "To keep using this app, download the latest version."),
                Constant.heightSpacer,
                LinearProgressIndicator(
                  value: _progress,
                  semanticsValue: "${_progress.toInt() * 100}%",
                  backgroundColor: Colors.grey,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                Constant.heightSpacer,
                ElevatedButton(
                  onPressed: _status == FetchingStatus.loading
                      ? null
                      : () async {
                          if (_status == FetchingStatus.init) {
                            download(widget.activeVersion.link!);
                          } else if (_status == FetchingStatus.success) {
                            final path = await ALDownloaderPersistentFileManager
                                .getAbsolutePhysicalPathOfFileForUrl(
                                    widget.activeVersion.link!);

                            await OpenFilex.open(path);
                          }
                        },
                  child: Text(_status == FetchingStatus.success
                      ? "Open file"
                      : "Update"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
