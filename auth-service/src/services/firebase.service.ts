import { Injectable } from '@nestjs/common';
import { FirebaseAuthenticationService } from '@aginix/nestjs-firebase-admin';

@Injectable()
export class FirebaseService {
    constructor(private firebaseAuth: FirebaseAuthenticationService) {}


}
