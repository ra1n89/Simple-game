
/**
Контракт "Воин" (родитель "Военный юнит")
- получить силу атаки
- получить силу защиты

Суть псевдоигры:
Первый signer (игрок 1) деплоит контракт Базовой станции. У него есть база.
Деплоит контракт "Воина", "Лучника" - у него на базе есть теперь пара воинов
Второй signer (игрок 2) деплоит контракт Базовой станции. У него есть база.
Деплоит контракт "Воина", "Лучника" - у него на базе есть теперь пара воинов
Дальше игроки могут "сражаться".
Игрок 2 может попросить кого-то из военных юнитов атаковать кого-то у первого игрока.
В случает атаки, тот кого атакует "принимает атаку". Получает урон (сила атаки - сила защиты). Если дошло до нуля, то умирает.
При "смерти" все кристаллы отдаются на адрес юнита, который его убил. А если умирает "Базовая станция", то и все воины этой базовой станции тоже от этого умирают и отдают все свои кристаллы.
===================================================

 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
import 'militaryObj.sol';
import 'baseStation.sol';
// This is class that describes you smart contract.
contract warrior is militaryObj{
    
    struct Warrior {
        int strengthPower;
        int defendsPower;
        int lifes;
    }
    
    Warrior warrior = Warrior({
        strengthPower:10,
        defendsPower:10,
        lifes:2
    });
    int c;

/* 
  constructor(baseStation bstation) public {
        tvm.accept();
        //unitAddress = address(msg.sender);
        bstation.addUnit(this);
        //baseStationAdr = bstation;  
    }
*/
/* 
    constructor () public override{
    tvm.accept(); 
    warrior.strengthPower = 10;
    warrior.defendsPower = 15;
    warrior.lifes = 5;
    }
*/

    function acceptAttack(int attack) public override  {
        tvm.accept();
        //запоминаем адрес атакующего
        unitAddress1 = msg.sender;
        //отнимаем от силы защиты силу атаки
        warrior.defendsPower = warrior.defendsPower - attack ;
        //проверяем условие, если защита уменьшается меньше 0, то отнимаем 1 жизнь и перезаряжаем защиту
        if (warrior.defendsPower  <= 0){
            warrior.lifes = warrior.lifes - 1;
            warrior.defendsPower = 10;
        }
        //проверяем условие, если жизней не осталось то вызываемо функцию killedAndTransfer
        if (warrior.lifes==0){
            killedAndTransfer(unitAddress1);
        }                
    }
    //переопределенный метод получения силы защиты Воина
    function getDefendsPower () public view override returns (int) {
        return warrior.defendsPower;
    }
    //переопределенный метод атаки Воином
    function attackEnemy(playingObjInt unitAddress) public override checkOwnerAndAccept{
        unitAddress.acceptAttack(warrior.strengthPower);
    }

    //метод получения силы атаки Воина
    function getAttackPower() public override returns (int){
        return warrior.strengthPower;
    }
}
