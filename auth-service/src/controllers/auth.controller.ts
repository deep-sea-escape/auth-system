import { Body, Controller, Get, Post, Query, Res } from '@nestjs/common';
import { KakaoService } from 'src/services/kakao.service';

@Controller('auth')
export class AuthController {
    constructor(private readonly kakaoService: KakaoService) {}

    @Get("/test")
    sayHello(@Query('code') code: string) {
        return code;
    }

    @Post('login')
    async login(@Query('code') code: string): Promise<Map<string, any>> {
        return this.kakaoService.login(code);
    }
}
