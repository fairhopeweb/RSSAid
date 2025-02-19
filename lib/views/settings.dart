// @dart=2.9
import 'package:flutter/material.dart';
import 'package:rssaid/common/common.dart';
import 'package:rssaid/views/rules.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String _domain = "https://rsshub.app";
  String _rules = "";

  void initState() {
    super.initState();
    init();
  }

  Future<void> _fetchRules() async {
    await Common.refreshRules();
    setState(() {});
  }

  Future<void> init() async {
    final SharedPreferences prefs = await _prefs;
    if (prefs.containsKey("RSSHUB")) {
      setState(() {
        _domain = prefs.getString("RSSHUB");
      });
    }
    setState(() {
      _rules = prefs.getString("Rules");
    });
  }

  void setDomain(String domain) async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _domain = domain;
    });
    prefs.setString("RSSHUB", domain);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(AppLocalizations.of(context).settings, style: Theme.of(context).textTheme.headline6),
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                })),
        body: Container(
          margin: EdgeInsets.only(top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context).common),
              CommonRows(_domain, setDomain, _fetchRules, _rules),
              Text(AppLocalizations.of(context).about),
              AboutRows()
            ],
          ),
        ));
  }
}

// ignore: must_be_immutable
class CommonRows extends StatelessWidget {
  String _domain;
  Function _domainSetCallback;
  String _rules;
  Function _refreshRulesCallBack;
  TextEditingController _domainController = new TextEditingController();

  CommonRows(String domain, Function domainSetFunc, Function _refreshRules,
      String rules) {
    this._domain = domain;
    this._domainController.text = domain;
    this._domainSetCallback = domainSetFunc;
    this._refreshRulesCallBack = _refreshRules;
    this._rules = rules;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        _buildHowUseSoftware(context),
        _buildRssHubDomain(context),
        _buildRules(context)
      ],
    );
  }

  Widget _buildRssHubDomain(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 24, right: 24, bottom: 8),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0,
      child: ListTile(
        leading: Icon(Icons.domain, color: Colors.orange),
        title: Text(
          "RSSHub URL",
          style: TextStyle(color: Colors.orange),
        ),
        onTap: () {
          _showDialog(context);
        },
      ),
    );
  }

  Widget _buildHowUseSoftware(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 24, right: 24, bottom: 8),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0,
      child: ListTile(
        leading: Icon(Icons.apps, color: Colors.orange),
        title: Text(
          AppLocalizations.of(context).user_manual,
          style: TextStyle(color: Colors.orange),
        ),
        onTap: () {
          Common.launchInBrowser("https://docs.rsshub.app");
        },
      ),
    );
  }

  Widget _buildRules(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 24, right: 24, bottom: 8),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0,
      child: ListTile(
        leading: Icon(Icons.note, color: Colors.orange),
        title: Text(
          "Rules",
          style: TextStyle(color: Colors.orange),
        ),
        onTap: () {
          Navigator.of(context).push(
              new MaterialPageRoute<Null>(builder: (BuildContext context) {
            return new RulesDialog(_rules, _refreshRulesCallBack);
          }));
        },
      ),
    );
  }

  _showDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return new AlertDialog(
                // contentPadding: const EdgeInsets.all(16.0),
                content: Container(
                  child: TextField(
                    controller: _domainController,
                    decoration: new InputDecoration(labelText: 'Host'),
                  ),
                ),
                actions: <Widget>[
                  new FlatButton(
                      child: Text(AppLocalizations.of(context).cancel,
                          style: TextStyle(color: Colors.orange)),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  new FlatButton(
                      child: Text(AppLocalizations.of(context).sure,
                          style: TextStyle(color: Colors.orange)),
                      onPressed: () {
                        if (_domainController.text != _domain) {
                          _domainSetCallback(_domainController.text);
                        }
                        Navigator.pop(context);
                      })
                ],
              );
            },
          );
        });
  }
}

class AboutRows extends StatelessWidget {
  Widget _buildAboutItem(
      String name, IconData icon, String trailing, String url) {
    return Card(
      margin: EdgeInsets.only(left: 24, right: 24, bottom: 8),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0,
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(
          name,
          style: TextStyle(color: Colors.orange),
        ),
        trailing: trailing.isNotEmpty ? Text(trailing) : null,
        onTap: url.isNotEmpty
            ? () async {
                await Common.launchInBrowser(url);
              }
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        _buildAboutItem("Version", Icons.info, "v1.6.4", ""),
        _buildAboutItem("Github", Icons.favorite, "",
            "https://github.com/LeetaoGoooo/RSSAid"),
        _buildAboutItem(
            'Telegram', Icons.group, "", "https://t.me/rssaid"),
      ],
    );
  }
}
