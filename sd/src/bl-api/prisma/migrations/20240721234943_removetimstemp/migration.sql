/*
  Warnings:

  - You are about to drop the column `created_on` on the `Pokemons` table. All the data in the column will be lost.
  - You are about to drop the column `updated_on` on the `Pokemons` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Pokemons" DROP COLUMN "created_on",
DROP COLUMN "updated_on";
