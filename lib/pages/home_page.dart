import 'package:flutter/material.dart';
import 'package:format_generator/pages/detail_page.dart';
import 'package:format_generator/pages/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});
  final c = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Format Generator'),
        actions: [
          IconButton(
              onPressed: () {
                c.getDataSpreadsheet();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: GetBuilder<HomeController>(builder: (c) {
        if (c.data == null) {
          return  const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: c.to,
                decoration: const InputDecoration(
                  label: Text('To'),
                ),
              ),
              TextField(
                controller: c.link,
                decoration: const InputDecoration(
                  label: Text('Link'),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                  'Current Index: ${c.currentIndex} of ${c.listExcel['name']?.length}'),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      c.prevPage();
                    },
                    child: const Icon(Icons.skip_previous),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      c.generateResult();
                    },
                    child: const Text('Generate'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      c.nextPage();
                    },
                    child: const Icon(Icons.skip_next),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.to(DetailPage(data: c.listExcel));
                          },
                          icon: const Icon(Icons.list)),
                      IconButton(
                          onPressed: () => c.copyText(),
                          icon: const Icon(Icons.copy)),
                    ],
                  )),
              TextField(
                controller: c.result,
                maxLines: 20,
                decoration: const InputDecoration.collapsed(
                  hintText: 'result',
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
