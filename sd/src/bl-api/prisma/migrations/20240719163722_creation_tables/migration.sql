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
    "spawn_chance" DECIMAL(10,2) NOT NULL,
    "avg_spawns" INTEGER NOT NULL,
    "spawn_time" TEXT NOT NULL,
    "weaknessesid" TEXT NOT NULL,
    "created_on" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_on" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Pokemons_pkey" PRIMARY KEY ("pokeid")
);

-- CreateTable
CREATE TABLE "Type" (
    "typeid" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Type_pkey" PRIMARY KEY ("typeid")
);

-- CreateTable
CREATE TABLE "Weaknesses" (
    "weaknessesid" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Weaknesses_pkey" PRIMARY KEY ("weaknessesid")
);

-- AddForeignKey
ALTER TABLE "Pokemons" ADD CONSTRAINT "Pokemons_typeid_fkey" FOREIGN KEY ("typeid") REFERENCES "Type"("typeid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pokemons" ADD CONSTRAINT "Pokemons_weaknessesid_fkey" FOREIGN KEY ("weaknessesid") REFERENCES "Weaknesses"("weaknessesid") ON DELETE RESTRICT ON UPDATE CASCADE;
