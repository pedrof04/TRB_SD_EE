/*
  Warnings:

  - The primary key for the `Pokemons` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `pokeid` column on the `Pokemons` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `typeid` column on the `Pokemons` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `weaknessesid` column on the `Pokemons` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `Type` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `typeid` column on the `Type` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `Weaknesses` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `weaknessesid` column on the `Weaknesses` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- DropForeignKey
ALTER TABLE "Pokemons" DROP CONSTRAINT "Pokemons_typeid_fkey";

-- DropForeignKey
ALTER TABLE "Pokemons" DROP CONSTRAINT "Pokemons_weaknessesid_fkey";

-- AlterTable
ALTER TABLE "Pokemons" DROP CONSTRAINT "Pokemons_pkey",
DROP COLUMN "pokeid",
ADD COLUMN     "pokeid" SERIAL NOT NULL,
DROP COLUMN "typeid",
ADD COLUMN     "typeid" SERIAL NOT NULL,
DROP COLUMN "weaknessesid",
ADD COLUMN     "weaknessesid" SERIAL NOT NULL,
ADD CONSTRAINT "Pokemons_pkey" PRIMARY KEY ("pokeid");

-- AlterTable
ALTER TABLE "Type" DROP CONSTRAINT "Type_pkey",
DROP COLUMN "typeid",
ADD COLUMN     "typeid" SERIAL NOT NULL,
ALTER COLUMN "name" SET NOT NULL,
ALTER COLUMN "name" SET DATA TYPE TEXT,
ADD CONSTRAINT "Type_pkey" PRIMARY KEY ("typeid");

-- AlterTable
ALTER TABLE "Weaknesses" DROP CONSTRAINT "Weaknesses_pkey",
DROP COLUMN "weaknessesid",
ADD COLUMN     "weaknessesid" SERIAL NOT NULL,
ALTER COLUMN "name" SET NOT NULL,
ALTER COLUMN "name" SET DATA TYPE TEXT,
ADD CONSTRAINT "Weaknesses_pkey" PRIMARY KEY ("weaknessesid");

-- AddForeignKey
ALTER TABLE "Pokemons" ADD CONSTRAINT "Pokemons_typeid_fkey" FOREIGN KEY ("typeid") REFERENCES "Type"("typeid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pokemons" ADD CONSTRAINT "Pokemons_weaknessesid_fkey" FOREIGN KEY ("weaknessesid") REFERENCES "Weaknesses"("weaknessesid") ON DELETE RESTRICT ON UPDATE CASCADE;
