
/**
Контракт "Лучник" (родитель "Военный юнит")
- получить силу атаки
- получить силу защиты
 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'militaryObj.sol';


contract archer is militaryObj{
    
    struct Archer {
        int strengthPower;
        int defendsPower;
        int lifes;
    }
    
    Archer archer = Archer({
        strengthPower:10,
        defendsPower:10,
        lifes:2
    });
    uint a;

    //переопределенный метод принятия атаки
    function acceptAttack(int attack) public override {
        tvm.accept();
        //запоминаем адрес атакующего
        unitAddress1 = msg.sender;
        //отнимаем от силы защиты силу атаки
        archer.defendsPower = archer.defendsPower - attack; 
        //проверяем условие, если защита уменьшается меньше 0, то отнимаем 1 жизнь и перезаряжаем защиту
        if (archer.defendsPower  <= 0){
            archer.lifes = archer.lifes - 1;
            archer.defendsPower = 10;
        }
        //проверяем условие, если жизней не осталось то вызываемо функцию killedAndTransfer
        if (archer.lifes == 0){
            killedAndTransfer(unitAddress1);
        }             
}

    //переопределенный метод получения силы защиты лучника
    function getDefendsPower () public view override returns (int) {
        return archer.defendsPower;
    }
    
    //переопределенный метод атаки Лучником
     function attackEnemy(playingObjInt unitAddress) public override checkOwnerAndAccept{
        unitAddress.acceptAttack(archer.strengthPower);
    }

    //метод получения силы атаки Лучника
    function getAttackPower() public override returns (int){
        return archer.strengthPower;
    }
}
