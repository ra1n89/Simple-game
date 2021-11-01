
/*
Контракт "Игровой объект" (Реализует "Интерфейс Игровой объект")
- получить силу защиты
- принять атаку [адрес того, кто атаковал можно получить из msg] external
- проверить, убит ли объект (private)
- обработка гибели [вызов метода самоуничтожения (сл в списке)]
- отправка всех денег по адресу и уничтожение
- свойство с начальным количеством жизней (например, 5)
 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
import "playingObjInt.sol";

//создаём контрат "Игровой объект" реализацующий интерфейс игрового объекта
contract playingObj is playingObjInt {

    //формируем структуру которая будет унаследована в последующих контрактах
    struct PlayingObj {
        int strengthPower;
        int defendsPower;
        int lifes;
    }

    //задаём переменные для метода уничтожения юнита и отправки всех денег победившему юниту
    bool boun = true;
    uint16 flag = 160;
    uint128 value = 1;
    address unitAddress1;

    //создаём игровой объект
    PlayingObj playingObj = PlayingObj({
        strengthPower:100,
        defendsPower:10,
        lifes:1
    });
  
    //метод принимает атаку с любого контракта  (функция деларирована в  интерфейсе)
    function acceptAttack(int attack) public virtual override {
        tvm.accept();
        //запоминаем адрес атакующего
        unitAddress1 = msg.sender;
        //отнимаем от силы защиты силу атаки
        playingObj.defendsPower = playingObj.defendsPower - attack ;

        //проверяем условие, если защита уменьшается меньше 0, то отнимаем 1 жизнь
        if (playingObj.defendsPower <= 0) {
            playingObj.lifes = playingObj.lifes - 1;
        }
         //проверяем условие, если жизней не осталось то вызываемо функцию killedAndTransfer
        if (playingObj.lifes==0){
            killedAndTransfer(unitAddress1);
        }     
    }
         
    //отправка всех денег по адресу и уничтожение
    function killedAndTransfer(address unitAddress) public virtual {
        tvm.accept();
        unitAddress.transfer(value, boun, flag);
    }

    //метод проверки оставшейся защиты объекта
    function getDefendsPower () public view virtual returns (int) {
    return playingObj.defendsPower;
    }

  
}  

    



