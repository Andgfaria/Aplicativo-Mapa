//
//  GerenciadorConfiguracao.m
//  AplicativoMapa
//
//  Created by André Gimenez Faria on 05/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "GerenciadorConfiguracao.h"
#import "Configuracao.h"

@implementation GerenciadorConfiguracao

-(GerenciadorConfiguracao *)init {
    self = [super init];
    if (self) {
        configuracoesSalvas = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

-(void) carregarConfiguracoesPadrao {
        NSNumber *precoLitro = [[NSNumber alloc] initWithDouble:1.90];
        NSNumber *consumoLitro = [[NSNumber alloc] initWithDouble:21];
        NSNumber *gastoMaximo = [[NSNumber alloc] initWithDouble:200];
        NSString *preferenciaEstiloMapa = @"normal";
        [configuracoesSalvas setObject:precoLitro forKey:@"precoLitro"];
        [configuracoesSalvas setObject:consumoLitro forKey:@"consumoLitro"];
        [configuracoesSalvas setObject:gastoMaximo forKey:@"gastoMaximo"];
        [configuracoesSalvas setObject:preferenciaEstiloMapa forKey:@"preferenciaEstiloMapa"];
        [configuracoesSalvas setBool:YES forKey:@"configuracoesJaSalvas"];
        [configuracoesSalvas setBool:NO forKey:@"temaAlternativo"];
        [configuracoesSalvas synchronize];
}

-(Configuracao *) retornarConfiguracoes {
        NSNumber *precoLitro = [configuracoesSalvas objectForKey:@"precoLitro"];
        NSNumber *consumoLitro = [configuracoesSalvas objectForKey:@"consumoLitro"];
        NSNumber *gastoMaximo = [configuracoesSalvas objectForKey:@"gastoMaximo"];
        NSString *preferenciaEstiloMapa = [configuracoesSalvas stringForKey:@"preferenciaEstiloMapa"];
        BOOL temaAlternativo = [configuracoesSalvas boolForKey:@"temaAlternativo"];
        Configuracao *nova = [[Configuracao alloc] initWithConsumoLitro:consumoLitro eprecoLitro:precoLitro egastoMaximo:gastoMaximo ePreferenciaEstiloMapa:preferenciaEstiloMapa eTemaAlternativo:temaAlternativo];
        return nova;
}

-(void) armazenarConfiguracoes:(Configuracao *)configuracoes {
    [configuracoesSalvas setObject:[configuracoes precoLitro] forKey:@"precoLitro"];
    [configuracoesSalvas setObject:[configuracoes consumoLitro] forKey:@"consumoLitro"];
    [configuracoesSalvas setObject:[configuracoes gastoMaximo] forKey:@"gastoMaximo"];
    [configuracoesSalvas setObject:[configuracoes preferenciaEstiloMapa] forKey:@"preferenciaEstiloMapa"];
    [configuracoesSalvas setBool:[configuracoes temaAlternativo] forKey:@"temaAlternativo"];
    [configuracoesSalvas synchronize];
}

@end
