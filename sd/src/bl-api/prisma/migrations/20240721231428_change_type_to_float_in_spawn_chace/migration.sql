/*
  Warnings:

  - You are about to alter the column `spawn_chance` on the `Pokemons` table. The data in that column could be lost. The data in that column will be cast from `Decimal(10,2)` to `DoublePrecision`.

*/
-- AlterTable
ALTER TABLE "Pokemons" ALTER COLUMN "spawn_chance" SET DATA TYPE DOUBLE PRECISION;
