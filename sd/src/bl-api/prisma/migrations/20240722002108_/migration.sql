/*
  Warnings:

  - The primary key for the `Type` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Type` table. All the data in the column will be lost.
  - The `name` column on the `Type` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the `Pokemon` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Weakness` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_PokemonTypes` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_PokemonWeaknesses` table. If the table is not empty, all the data it contains will be lost.
  - The required column `typeid` was added to the `Type` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.

*/
-- DropForeignKey
ALTER TABLE "_PokemonTypes" DROP CONSTRAINT "_PokemonTypes_A_fkey";

-- DropForeignKey
ALTER TABLE "_PokemonTypes" DROP CONSTRAINT "_PokemonTypes_B_fkey";

-- DropForeignKey
ALTER TABLE "_PokemonWeaknesses" DROP CONSTRAINT "_PokemonWeaknesses_A_fkey";

-- DropForeignKey
ALTER TABLE "_PokemonWeaknesses" DROP CONSTRAINT "_PokemonWeaknesses_B_fkey";

-- DropIndex
DROP INDEX "Type_name_idx";

-- DropIndex
DROP INDEX "Type_name_key";

-- AlterTable
ALTER TABLE "Type" DROP CONSTRAINT "Type_pkey",
DROP COLUMN "id",
ADD COLUMN     "typeid" TEXT NOT NULL,
DROP COLUMN "name",
ADD COLUMN     "name" TEXT[],
ADD CONSTRAINT "Type_pkey" PRIMARY KEY ("typeid");

-- DropTable
DROP TABLE "Pokemon";

-- DropTable
DROP TABLE "Weakness";

-- DropTable
DROP TABLE "_PokemonTypes";

-- DropTable
DROP TABLE "_PokemonWeaknesses";

-- CreateTable
CREATE TABLE "Pokemons" (
    "pokeid" TEXT NOT NULL,
    "num" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "img" TEXT NOT NULL,
    "typeid" TEXT NOT NULL,
    "height" TEXT NOT NULL,
    "weight" TEXT NOT NULL,
    "candy" TEXT NOT NULL,
    "candy_count" INTEGER NOT NULL,
    "egg" TEXT NOT NULL,
    "spawn_chance" DOUBLE PRECISION NOT NULL,
    "avg_spawns" DOUBLE PRECISION NOT NULL,
    "spawn_time" TEXT NOT NULL,
    "weaknessesid" TEXT NOT NULL,

    CONSTRAINT "Pokemons_pkey" PRIMARY KEY ("pokeid")
);

-- CreateTable
CREATE TABLE "Weaknesses" (
    "weaknessesid" TEXT NOT NULL,
    "name" TEXT[],

    CONSTRAINT "Weaknesses_pkey" PRIMARY KEY ("weaknessesid")
);

-- CreateIndex
CREATE UNIQUE INDEX "Pokemons_num_key" ON "Pokemons"("num");

-- AddForeignKey
ALTER TABLE "Pokemons" ADD CONSTRAINT "Pokemons_typeid_fkey" FOREIGN KEY ("typeid") REFERENCES "Type"("typeid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pokemons" ADD CONSTRAINT "Pokemons_weaknessesid_fkey" FOREIGN KEY ("weaknessesid") REFERENCES "Weaknesses"("weaknessesid") ON DELETE RESTRICT ON UPDATE CASCADE;
