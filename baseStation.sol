
/**
Контракт "Базовая станция" (Родитель "Игровой объект")
- получить силу защиты
- Добавить военный юнит (добавляет адрес военного юнита в массив или другую структуру данных)
- Убрать военный юнит
- обработка гибели [вызов метода самоуничтожения + вызов метода смерти для каждого из военных юнитов базы]
 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
import "playingObj.sol";


// This is class that describes you smart contract.
contract baseStation is playingObj {

    //формируем структуру меппинг где ключом к адресу будет сам адрес
    mapping (address=>address) public units;
    
    //функция добавить юнита 
    function addUnit (address unit) public {
        tvm.accept();
        units[unit] = unit;
    }
    
    //функция удалить юнита 
    function removeUnit (address unit) public  {
        tvm.accept();
        delete units[unit];
    }
}
