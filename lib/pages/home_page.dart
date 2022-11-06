import 'package:crypto_app/blocs/bloc/crypto_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto Watcher'),
        backgroundColor: Colors.purple.shade900,
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
            Colors.deepPurple,
            ],
          ),
        ),
        child: BlocBuilder<CryptoBloc, CryptoState>(
          builder: (context, state) {
            if (state.status == Status.loaded) {
              return RefreshIndicator(
                color: Theme.of(context).colorScheme.secondary,
                onRefresh: () async {
                  context.read<CryptoBloc>().add(RefreshCoins());
                },
                child: ListView.builder(
                  itemCount: state.coins.length,
                  itemBuilder: (BuildContext context, int index) {
                    final coin = state.coins[index];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text(
                            coin.fullName,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            coin.name,
                            style: const TextStyle(color: Colors.white70),
                          ),
                          trailing: Text(
                            '\$${coin.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  },
                ),
              );
            }
            if (state.status == Status.error) {
              return Center(
                child: Text(
                  state.onError.message,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  Theme.of(context).colorScheme.secondary,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
