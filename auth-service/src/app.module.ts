import { FirebaseAdminModule } from '@aginix/nestjs-firebase-admin';
import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthController } from './controllers/auth.controller';
import { FirebaseService } from './services/firebase.service';
import { KakaoService } from './services/kakao.service';
import * as admin from 'firebase-admin'
import { HttpModule } from '@nestjs/axios';

@Module({
  imports: [
    FirebaseAdminModule.forRootAsync({
      useFactory: () => ({
        credential: admin.credential.applicationDefault()
      })
    }),
    HttpModule
  ],
  controllers: [AppController, AuthController],
  providers: [AppService, FirebaseService, KakaoService],
})
export class AppModule {}
