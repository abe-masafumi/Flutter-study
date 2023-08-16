import 'package:flutter_test/flutter_test.dart';
import 'package:study/model/goto_model.dart';

void main() {
  GotoModel target = GotoModel();
  setUp(() {
    target = GotoModel();
  });

  group("ベース", () {
    test("初期値", () {
      expect(target.price, 0);
    });

    test("価格を入れる", () {
      expect(target.price, 0);
      target.setPrice(100);
      expect(target.price, 100);
    });

    test("宿泊日数", () {
      expect(target.stay, 0);
      target.setStay(1);
      expect(target.stay, 1);
    });

    test("宿泊人数", () {
      expect(target.person, 1);
      target.setPerson(2);
      expect(target.person, 2);
    });
  });

  group("お一人様計算", () {
    test("1人1泊", () {
      target.setPerson(1);
      target.setStay(1);
      target.setPrice(20000);
      expect(target.price, 20000);

      expect(target.getMinus(), 7000);
      expect(target.getPay(), 13000);
      expect(target.getCoupone(), 3000);
    });

    test("1人1泊クーポン四捨五入", () {
      target.setPerson(1);
      target.setStay(1);
      target.setPrice(30000);
      expect(target.price, 30000);

      expect(target.getMinus(), 10500);
      expect(target.getPay(), 19500);
      expect(target.getCoupone(), 5000);
    });

    test("1人1泊クーポン制限超え", () {
      target.setPerson(1);
      target.setStay(1);
      target.setPrice(100000);
      expect(target.price, 100000);

      expect(target.getMinus(), 14000);
      expect(target.getPay(), 86000);
      expect(target.getCoupone(), 6000);
    });

    test("1人2泊", () {
      target.setPerson(1);
      target.setStay(2);
      target.setPrice(100000);
      expect(target.price, 100000);

      expect(target.getMinus(), 28000);
      expect(target.getPay(), 72000);
      expect(target.getCoupone(), 12000);
    });
    test("1人日帰り高級", () {
      target.setPerson(1);
      target.setStay(0);
      target.setPrice(100000);
      expect(target.price, 100000);

      expect(target.getMinus(), 7000);
      expect(target.getPay(), 93000);
      expect(target.getCoupone(), 3000);
    });

    test("1人日帰り手頃", () {
      target.setPerson(1);
      target.setStay(0);
      target.setPrice(5000);
      expect(target.price, 5000);

      expect(target.getMinus(), 1750);
      expect(target.getPay(), 3250);
      expect(target.getCoupone(), 1000);
    });

    test("1人7泊", () {
      target.setPerson(1);
      target.setStay(7);
      target.setPrice(300000);
      expect(target.price, 300000);

      expect(target.getMinus(), 98000);
      expect(target.getPay(), 202000);
      expect(target.getCoupone(), 42000);
    });

    test("1人8泊", () {
      target.setPerson(1);
      target.setStay(8);
      target.setPrice(300000);
      expect(target.price, 300000);

      expect(target.getMinus(), 98000);
      expect(target.getPay(), 202000);
      expect(target.getCoupone(), 42000);
    });
  });

  group("お3人様計算", () {
    test("3人1泊", () {
      target.setPerson(3);
      target.setStay(1);
      target.setPrice(20000);
      expect(target.price, 20000);

      expect(target.getMinus(), 7000);
      expect(target.getPay(), 13000);
      expect(target.getCoupone(), 3000);
    });

    test("3人1泊クーポン制限超え", () {
      target.setPerson(3);
      target.setStay(1);
      target.setPrice(300000);
      expect(target.price, 300000);

      expect(target.getMinus(), 42000);
      expect(target.getPay(), 258000);
      expect(target.getCoupone(), 18000);
    });

    test("3人2泊", () {
      target.setPerson(3);
      target.setStay(2);
      target.setPrice(300000);
      expect(target.price, 300000);

      expect(target.getMinus(), 84000);
      expect(target.getPay(), 216000);
      expect(target.getCoupone(), 36000);
    });
    test("3人日帰り高級", () {
      target.setPerson(3);
      target.setStay(0);
      target.setPrice(300000);
      expect(target.price, 300000);

      expect(target.getMinus(), 21000);
      expect(target.getPay(), 279000);
      expect(target.getCoupone(), 9000);
    });

    test("3人日帰り手頃", () {
      target.setPerson(3);
      target.setStay(0);
      target.setPrice(10000);
      expect(target.price, 10000);

      expect(target.getMinus(), 3500);
      expect(target.getPay(), 6500);
      expect(target.getCoupone(), 2000);
    });
  });
  group("実データ", () {
    test("日帰り", () {
      target.setPerson(2);
      target.setStay(0);
      target.setPrice(18100);
      expect(target.price, 18100);

      int diff = 35;
      expect(target.getMinus(), 6300 + diff);
      expect(target.getPay(), 11800 - diff);
      expect(target.getCoupone(), 3000);
    });

    test("2名2泊 JR東海ツアーズ", () {
      target.setPerson(2);
      target.setStay(2);
      target.setPrice(88000);
      expect(target.price, 88000);

      int diff = 1;
      expect(target.getMinus(), 30800 - diff);
      expect(target.getPay(), 57200 + diff);
      expect(target.getCoupone(), 13000);
    });

    test("2名3泊", () {
      target.setPerson(2);
      target.setStay(3);
      target.setPrice(136300);
      expect(target.price, 136300);

      int diff = 5;
      expect(target.getMinus(), 47700 + diff);
      expect(target.getPay(), 88600 - diff);
      expect(target.getCoupone(), 20000);
    });

    test("2名2泊ドラえもん", () {
      target.setPerson(2);
      target.setStay(3);
      target.setPrice(56400 * 2);
      expect(target.price, 56400 * 2);

      int diff = -80;
      expect(target.getMinus(), 19700 * 2 - diff);
      expect(target.getPay(), 73920 - 520 + diff);
      expect(target.getCoupone(), 17000);
    });

    test("1名1泊 JR東海ツアーズ", () {
      target.setPerson(1);
      target.setStay(1);
      target.setPrice(28800);
      expect(target.price, 28800);

      expect(target.getMinus(), 10080);
      expect(target.getPay(), 18720);
      expect(target.getCoupone(), 4000);
    });

    test("2名2泊豪華", () {
      target.setPerson(2);
      target.setStay(2);
      target.setPrice(81000 * 2);
      expect(target.price, 81000 * 2);

      int diff = 700;
      expect(target.getMinus(), 56700 - diff);
      expect(target.getPay(), 105300 + diff);
      expect(target.getCoupone(), 24000);
    });
  });
}