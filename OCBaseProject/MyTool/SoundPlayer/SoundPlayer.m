//
//  SoundPlayer.m
//  niaoyutong
//
//  Created by zhangmingwei on 2017/5/10.
//  Copyright © 2017年 niaoyutong. All rights reserved.
//

#import "SoundPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "Tool.h"
static SoundPlayer *soundplayer = nil;

@interface SoundPlayer()<AVSpeechSynthesizerDelegate>

@property (nonatomic, strong) AVSpeechSynthesizer *synth;

@end

@implementation SoundPlayer

+(SoundPlayer *)defaltManager {
    if(soundplayer == nil) {
        soundplayer = [[SoundPlayer alloc]init];
    }
    return soundplayer;
}
//播放声音
- (void)play:(NSString *)string languageType:(LanguageType)lanType {
    
    if(string && string.length > 0){
        [Tool volumeBig]; // 播放声音大
        // 日文：ja-JP  英文：en-US
        AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:string];
        utterance.volume = 1.0;
        utterance.rate = 0.54;
        //音调  --  为语句指定pitchMultiplier ，可以在播放特定语句时改变声音的音调、pitchMultiplier的允许值一般介于0.5(低音调)和2.0(高音调)之间
        utterance.pitchMultiplier = 0.8;
        //让语音合成器在播放下一句之前有短暂时间的暂停，也可以类似的设置preUtteranceDelay
        utterance.postUtteranceDelay = 0.1;
        utterance.preUtteranceDelay = 0.1; // 修复了莫名其妙的语音就播放不了的bug
        self.synth = [[AVSpeechSynthesizer alloc] init];
        //获取当前系统语音
        NSString *preferredLang = @"zh-CN";
        if (lanType == LanguageTypeEnglish) {
            preferredLang = @"en_US";
        } else if (lanType == LanguageTypeJp) {
            preferredLang = @"ja-JP";
        }
        
        AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:[NSString stringWithFormat:@"%@",preferredLang]];
        utterance.voice = voice;
        self.synth.delegate = self;
        [self.synth speakUtterance:utterance];
    }
}

/// 停止播放声音
- (void)stopAction {
    if (self.synth) {
        [self.synth stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSoudDidStop object:nil];
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSoudDidStop object:nil];
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationSoudDidStop object:nil];
}

@end


/*
 AVSpeech支持的语言种类
 
 "[AVSpeechSynthesisVoice 0x978a0b0]Language: th-TH",
 "[AVSpeechSynthesisVoice 0x977a450]Language: pt-BR",
 "[AVSpeechSynthesisVoice 0x977a480]Language: sk-SK",
 "[AVSpeechSynthesisVoice 0x978ad50]Language: fr-CA",
 "[AVSpeechSynthesisVoice 0x978ada0]Language: ro-RO",
 "[AVSpeechSynthesisVoice 0x97823f0]Language: no-NO",
 "[AVSpeechSynthesisVoice 0x978e7b0]Language: fi-FI",
 "[AVSpeechSynthesisVoice 0x978af50]Language: pl-PL",
 "[AVSpeechSynthesisVoice 0x978afa0]Language: de-DE",
 "[AVSpeechSynthesisVoice 0x978e390] Language:nl-NL",
 "[AVSpeechSynthesisVoice 0x978b030]Language: id-ID",
 "[AVSpeechSynthesisVoice 0x978b080]Language: tr-TR",
 "[AVSpeechSynthesisVoice 0x978b0d0]Language: it-IT",
 "[AVSpeechSynthesisVoice 0x978b120]Language: pt-PT",
 "[AVSpeechSynthesisVoice 0x978b170]Language: fr-FR",
 "[AVSpeechSynthesisVoice 0x978b1c0]Language: ru-RU",
 "[AVSpeechSynthesisVoice0x978b210]Language: es-MX",
 "[AVSpeechSynthesisVoice 0x978b2d0]Language: zh-HK",
 "[AVSpeechSynthesisVoice 0x978b320]Language: sv-SE",
 "[AVSpeechSynthesisVoice 0x978b010]Language: hu-HU",
 "[AVSpeechSynthesisVoice 0x978b440]Language: zh-TW",
 "[AVSpeechSynthesisVoice 0x978b490]Language: es-ES",
 "[AVSpeechSynthesisVoice 0x978b4e0]Language: zh-CN",
 "[AVSpeechSynthesisVoice 0x978b530]Language: nl-BE",
 "[AVSpeechSynthesisVoice 0x978b580]Language: en-GB",
 "[AVSpeechSynthesisVoice 0x978b5d0]Language: ar-SA",
 "[AVSpeechSynthesisVoice 0x978b620]Language: ko-KR",
 "[AVSpeechSynthesisVoice 0x978b670]Language: cs-CZ",
 "[AVSpeechSynthesisVoice 0x978b6c0]Language: en-ZA",
 "[AVSpeechSynthesisVoice 0x978aed0]Language: en-AU",
 "[AVSpeechSynthesisVoice 0x978af20]Language: da-DK",
 "[AVSpeechSynthesisVoice 0x978b810]Language: en-US",
 "[AVSpeechSynthesisVoice 0x978b860]Language: en-IE",
 "[AVSpeechSynthesisVoice 0x978b8b0]Language: hi-IN",
 "[AVSpeechSynthesisVoice 0x978b900]Language: el-GR",
 "[AVSpeechSynthesisVoice 0x978b950]Language: ja-JP" )

*/

