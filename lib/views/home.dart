import 'package:flutter/material.dart';
import 'package:task_creator/models/task.dart';
import 'package:task_creator/services/local_storage.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.onPressed, required this.isDark})
      : super(key: key);
  final void Function() onPressed;
  final bool isDark;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _key = GlobalKey<FormState>();
  final _taskInputController = TextEditingController();
  List<Task> tasks = [];
  late LocalStorage storage;

  @override
  void initState() {
    super.initState();
    storage = LocalStorage();
    initTask();
  }

  void initTask() async {
    await storage.init();
    if (storage.getTasks() != null) {
      setState(() {
        tasks = Task.decode(storage.getTasks()!);
      });
    }
  }

  void updateTask() {
    storage.storeData(Task.encode(tasks));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 30.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Task \nCreator',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  IconButton(
                    onPressed: widget.onPressed,
                    icon: Icon(
                        widget.isDark ? Icons.dark_mode : Icons.light_mode),
                  ),
                ],
              ),
              Form(
                key: _key,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _taskInputController,
                        style: Theme.of(context).textTheme.bodyText1,
                        validator: (String? value) {
                          if (value!.isNotEmpty) {
                            return null;
                          }
                          return 'Task must not be empty';
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          setState(() {
                            tasks.insert(
                              0,
                              Task(title: _taskInputController.text),
                            );
                            updateTask();
                            _taskInputController.clear();
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Task Successfully Added'),
                            ),
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                      ),
                    )
                  ],
                ),
              ),
              Text(
                'Tasks ${tasks.where((task) => task.isDone).length}/${tasks.length}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onLongPress: () {
                        setState(() {
                          tasks.remove(tasks[index]);
                        });
                        updateTask();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Task Successfully Deleted'),
                          ),
                        );
                      },
                      onTap: () {
                        setState(() {
                          tasks[index].triggerIsDone();
                        });
                        updateTask();
                      },
                      leading: tasks[index].isDone
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                          : const Icon(Icons.circle),
                      title: Text(
                        tasks[index].title,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
