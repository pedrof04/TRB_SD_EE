/*
  Warnings:

  - You are about to alter the column `spawn_chance` on the `Pokemons` table. The data in that column could be lost. The data in that column will be cast from `DoublePrecision` to `Decimal(10,2)`.
  - You are about to alter the column `avg_spawns` on the `Pokemons` table. The data in that column could be lost. The data in that column will be cast from `DoublePrecision` to `Integer`.
  - Made the column `candy_count` on table `Pokemons` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "Pokemons" ALTER COLUMN "candy_count" SET NOT NULL,
ALTER COLUMN "spawn_chance" SET DATA TYPE DECIMAL(10,2),
ALTER COLUMN "avg_spawns" SET DATA TYPE INTEGER;
