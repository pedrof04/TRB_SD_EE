/*
  Warnings:

  - The primary key for the `Type` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `typeid` on the `Type` table. All the data in the column will be lost.
  - You are about to drop the `Pokemons` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Weaknesses` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[name]` on the table `Type` will be added. If there are existing duplicate values, this will fail.
  - The required column `id` was added to the `Type` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.

*/
-- DropForeignKey
ALTER TABLE "Pokemons" DROP CONSTRAINT "Pokemons_typeid_fkey";

-- DropForeignKey
ALTER TABLE "Pokemons" DROP CONSTRAINT "Pokemons_weaknessesid_fkey";

-- AlterTable
ALTER TABLE "Type" DROP CONSTRAINT "Type_pkey",
DROP COLUMN "typeid",
ADD COLUMN     "id" TEXT NOT NULL,
ADD CONSTRAINT "Type_pkey" PRIMARY KEY ("id");

-- DropTable
DROP TABLE "Pokemons";

-- DropTable
DROP TABLE "Weaknesses";

-- CreateTable
CREATE TABLE "Pokemon" (
    "id" TEXT NOT NULL,
    "num" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "img" TEXT NOT NULL,
    "height" TEXT NOT NULL,
    "weight" TEXT NOT NULL,
    "candy" TEXT NOT NULL,
    "candy_count" INTEGER NOT NULL,
    "egg" TEXT NOT NULL,
    "spawn_chance" DOUBLE PRECISION NOT NULL,
    "avg_spawns" DOUBLE PRECISION NOT NULL,
    "spawn_time" TEXT NOT NULL,

    CONSTRAINT "Pokemon_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Weakness" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Weakness_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_PokemonTypes" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_PokemonWeaknesses" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Pokemon_num_key" ON "Pokemon"("num");

-- CreateIndex
CREATE INDEX "Pokemon_num_idx" ON "Pokemon"("num");

-- CreateIndex
CREATE UNIQUE INDEX "Weakness_name_key" ON "Weakness"("name");

-- CreateIndex
CREATE INDEX "Weakness_name_idx" ON "Weakness"("name");

-- CreateIndex
CREATE UNIQUE INDEX "_PokemonTypes_AB_unique" ON "_PokemonTypes"("A", "B");

-- CreateIndex
CREATE INDEX "_PokemonTypes_B_index" ON "_PokemonTypes"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_PokemonWeaknesses_AB_unique" ON "_PokemonWeaknesses"("A", "B");

-- CreateIndex
CREATE INDEX "_PokemonWeaknesses_B_index" ON "_PokemonWeaknesses"("B");

-- CreateIndex
CREATE UNIQUE INDEX "Type_name_key" ON "Type"("name");

-- CreateIndex
CREATE INDEX "Type_name_idx" ON "Type"("name");

-- AddForeignKey
ALTER TABLE "_PokemonTypes" ADD CONSTRAINT "_PokemonTypes_A_fkey" FOREIGN KEY ("A") REFERENCES "Pokemon"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PokemonTypes" ADD CONSTRAINT "_PokemonTypes_B_fkey" FOREIGN KEY ("B") REFERENCES "Type"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PokemonWeaknesses" ADD CONSTRAINT "_PokemonWeaknesses_A_fkey" FOREIGN KEY ("A") REFERENCES "Pokemon"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PokemonWeaknesses" ADD CONSTRAINT "_PokemonWeaknesses_B_fkey" FOREIGN KEY ("B") REFERENCES "Weakness"("id") ON DELETE CASCADE ON UPDATE CASCADE;
