import { HttpService } from '@nestjs/axios';
import { Injectable } from '@nestjs/common';
import { firstValueFrom } from 'rxjs';

@Injectable()
export class KakaoService {
    constructor(private readonly httpService: HttpService) {}

    async login(authorizeCode: string): Promise<Map<string, any>> {
        const accessToken: Promise<string> = this.getAccessToken(authorizeCode);
        const userInfo: Promise<Map<string, any>> = this.getUserInfo(accessToken)
        return userInfo;
    }
    async getAccessToken(authorizeCode: string): Promise<string> {
        let accessToken: string = "";
        let refreshToken: string = "";
        let requestURL = 
            "https://kauth.kakao.com/oauth/token"
            + "grant_type=authorization_code"
            + "&client_id=f70d02498728ec87779fe9f76ed01da3"
            + "&redirect_uri=http://127.0.0.1:8080/auth/kakao/signIn"
            + `&code=${authorizeCode}`;
            

        
        const response = await firstValueFrom(this.httpService.post(requestURL));
        accessToken = response.data.access_token;

        return accessToken;
    }
    async getUserInfo(accessToken: Promise<string>): Promise<Map<string, any>> {
        let userInfo: Map<string, any> = new Map();
        let requestURL = "https://kapi.kakao.com/v2/user/me";

        const user = await firstValueFrom(this.httpService.get(requestURL, {
            headers: { Authorization: `Bearer ${accessToken}` },
        }));

        const { properties, kakao_account, nickname, profile_image, email } = user.data;
        console.log(user.data);

        if (!user) throw new DOMException();

        userInfo.set('nickname', nickname);
        userInfo.set('email', email);
        userInfo.set('profile_image', profile_image);

        return userInfo;
    }

    


}
