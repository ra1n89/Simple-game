
/**
 Контракт "Военный юнит" (Родитель "Игровой объект")
- конструктор принимает "Базовая станция" и вызывает метод "Базовой Станции" "Добавить военный юнит" а у себя сохраняет адрес "Базовой станции"
- атаковать (принимает ИИО [его адрес])
- получить силу атаки
- получить силу защиты
- обработка гибели [вызов метода самоуничтожения + убрать военный юнит из базовой станции]
- смерть из-за базы (проверяет, что вызов от родной базовой станции только будет работать) [вызов метода самоуничтожения]
 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
import 'playingObj.sol';
import 'baseStation.sol';
// This is class that describes you smart contract.
contract militaryObj is playingObj{
    address public unitAddress;
    address public baseStationAdr;

    modifier checkOwnerAndAccept {
        tvm.accept();
        _;
    }

/*/
// обращаемся к методу контракта "Базовая станция" и вносим адрес в структуру данных меппинга
    constructor(baseStation bstation) public virtual{
        tvm.accept();
        unitAddress = address(msg.sender);
        bstation.addUnit(this);
        baseStationAdr = bstation;  
    }
    */
    //метод атаки 
    function attackEnemy(playingObjInt unitAddress) public virtual checkOwnerAndAccept{
        unitAddress.acceptAttack(playingObj.strengthPower);
       
    }

    //метод получения силы атаки
    function getAttackPower() public virtual returns (int){
        return playingObj.strengthPower;
    }
    
}

