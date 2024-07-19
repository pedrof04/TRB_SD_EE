import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { Logger } from '@nestjs/common';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';

async function bootstrap() {
  const logger = new Logger('Bootstrap');
  const port = process.env.BL_API_PORT || 8080;
  const portSwagger = process.env.SWAGGER_PORT;

  const config = new DocumentBuilder()
    .setTitle('Pokedex')
    .setDescription('Detalhes dos Pokemons')
    .setVersion('1.0')
    .addTag('Pokedex')
    .build();

  try {
    const app = await NestFactory.create(AppModule, { cors: true });
    app.enableCors();

    //Inicia servidor local para API
    await app.listen(port, () => {
      const address = `http://localhost:${port}`;
      logger.log(`Server is running on ${address}`);
    });

    // Swagger
    const swaggerApp = await NestFactory.create(AppModule);
    const document = SwaggerModule.createDocument(swaggerApp, config);
    SwaggerModule.setup('/docs', swaggerApp, document);

    //Iniciar o Swagger
    await swaggerApp.listen(portSwagger, () => {
      const swaggerAddress = `http://localhost:${portSwagger}`;
      logger.log(`Swagger is running on ${swaggerAddress}/docs`);
    });
  } catch (err) {
    logger.error('Error starting server:', err);
    process.exit(1);
  }
}
bootstrap();
