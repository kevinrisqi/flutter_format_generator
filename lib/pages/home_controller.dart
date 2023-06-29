import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:format_generator/pages/home_services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // var text =
  //     "Assalammualaikum Warahmatullah Wabarakatuh\n\nBismillahirrohmanirrohim, \nTanpa mengurangi rasa hormat, perkenankan kami mengundang Bapak/Ibu/Saudara/i  untuk menghadiri acara kami:\n\nMauludy & Fauzi\n\nBerikut link undangan kami, untuk info lengkap dari acara bisa kunjungi :\n\nhttps://bit.ly/wedding-mauludy-fauzi-to-fenny-mellike\n\nMerupakan suatu kebahagiaan bagi kami apabila Bapak/Ibu/Teman-teman berkenan untuk hadir dan memberikan doa restu.\n\nMohon maaf perihal undangan hanya di bagikan melalui pesan ini.\n\n\nTerima kasih banyak atas perhatiannya.";
  TextEditingController to = TextEditingController();
  TextEditingController link = TextEditingController();
  TextEditingController result = TextEditingController();

  var listExcel = {
    "name": [],
    "link": [],
  };

  var data;

  int currentIndex = 0;

  RxBool isLoading = true.obs;

  String get resultGenerate {
    return "Assalammualaikum Warahmatullah Wabarakatuh\n\nBismillahirrohmanirrohim, \nTanpa mengurangi rasa hormat, perkenankan kami mengundang Bapak/Ibu/Saudara/i ${to.text} untuk menghadiri acara kami:\n\nMauludy & Fauzi\n\nBerikut link undangan kami, untuk info lengkap dari acara bisa kunjungi :\n\n${link.text}\n\nMerupakan suatu kebahagiaan bagi kami apabila Bapak/Ibu/Teman-teman berkenan untuk hadir dan memberikan doa restu.\n\nMohon maaf perihal undangan hanya di bagikan melalui pesan ini.\n\n\nTerima kasih banyak atas perhatiannya.";
  }

  void generateResult() {
    result.text = resultGenerate;
  }

  void copyText() {
    if (result.text != '') {
      Clipboard.setData(ClipboardData(text: result.text));
      Get.snackbar('Copied!', 'Text successfully copied!',
          backgroundColor: Colors.green);
    } else {
      Get.snackbar('Failed!', 'Text failed copied!',
          backgroundColor: Colors.red);
    }
  }

  Future<void> getDataSpreadsheet() async {
    try {
      listExcel['name']?.clear();
      listExcel['link']?.clear();
      // isLoading.value = true;
      data = await HomeServices().fetchDataFromSpreadsheet();
      isLoading.value = false;
      // data.values!.remove(0);
      // log('Data Excel: ${data.values?[0][1]}');
      for (var i = 1; i < data.values!.length; i++) {
        listExcel['name']!.add(data.values?[i][1]);
        listExcel['link']!.add(data.values?[i][2]);
      }
      log('List Excel: ${listExcel['name']?.length}');
      log('Is Loading: $isLoading');
      update();
    } catch (e) {
      log('$e');
    }
  }

  Future<void> nextPage() async {
    if (currentIndex == listExcel['name']?.length) {
      Get.snackbar('Max Index', 'Last Index',
          colorText: Colors.white, backgroundColor: Colors.red);
    } else {
      currentIndex++;
      to.text = listExcel['name']?[currentIndex];
      link.text = listExcel['link']?[currentIndex];
      generateResult();
    }
    update();
  }

  Future<void> prevPage() async {
    if (currentIndex == 0) {
      Get.snackbar('Min Index', 'First Index',
          colorText: Colors.white, backgroundColor: Colors.red);
    } else {
      currentIndex--;
      to.text = listExcel['name']?[currentIndex];
      link.text = listExcel['link']?[currentIndex];
      generateResult();
    }
    update();
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.microtask(
        () async {
          await getDataSpreadsheet();
          to.text = listExcel['name']?[currentIndex];
          link.text = listExcel['link']?[currentIndex];
        },
      );
    });

    super.onInit();
  }
}
