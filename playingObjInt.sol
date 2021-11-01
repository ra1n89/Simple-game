
/*
Интерфейс "Интерфейс Игровой объект" (ИИО).
- принять атаку
 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

// интерфейс для взаимодействия с контрактами реализующими данный интерфейс
interface playingObjInt {
   function acceptAttack(int attack) external;
}
