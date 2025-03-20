import 'dart:io';
import 'dart:math';

class Character {
  String name;
  int health;
  int attackPower;
  int defense;

  Character(this.name, this.health, this.attackPower, this.defense);

  bool isAlive() => health > 0;
}

class Player extends Character {
  Player(String name) : super(name, 50, 10, 5);

  void attack(Character enemy) {
    enemy.health -= attackPower;
    print("$name(이)가 ${enemy.name}에게 $attackPower의 데미지를 입혔습니다.");
  }

  void defend() {
    print("$name(이)가 방어 태세를 취합니다!");
  }
}

class Monster extends Character {
  Monster(String name, int health, int attackPower, int defense)
    : super(name, health, attackPower, defense);

  void attack(Player player) {
    int damage = max(0, attackPower - player.defense);
    player.health -= damage;
    print("$name(이)가 ${player.name}에게 $damage의 데미지를 입혔습니다.");
  }
}

void battle(Player player, Monster monster) {
  print(
    "새로운 몬스터가 나타났습니다! ${monster.name} - 체력: ${monster.health}, 공격력: ${monster.attackPower}\n",
  );

  while (player.isAlive() && monster.isAlive()) {
    print("${player.name}의 턴");
    print("행동을 선택하세요 (1: 공격, 2: 방어)");
    String? input = stdin.readLineSync();

    if (input == '1') {
      player.attack(monster);
    } else if (input == '2') {
      player.defend();
    } else {
      print("잘못된 입력입니다. 다시 선택해주세요.");
      continue;
    }

    if (!monster.isAlive()) {
      print("${monster.name}(을)를 물리쳤습니다!\n");
      break;
    }

    print("\n${monster.name}의 턴");
    monster.attack(player);

    if (!player.isAlive()) {
      print("${player.name}(이)가 쓰러졌습니다... 게임 오버!\n");
      return;
    }
  }

  print("다음 몬스터와 싸우시겠습니까? (y/n)");
  String? next = stdin.readLineSync();
  if (next?.toLowerCase() == 'y') {
    Monster nextMonster = Monster("Batman", 30, 12, 5);
    battle(player, nextMonster);
  } else {
    print("게임을 종료합니다!");
  }
}

void main() {
  print("캐릭터의 이름을 입력하세요: ");
  String? playerName = stdin.readLineSync();
  Player player = Player(playerName ?? "Player");

  print("게임을 시작합니다!\n");
  Monster firstMonster = Monster("Spiderman", 20, 5, 5);
  battle(player, firstMonster);
}
