//
//  Configuracao.m
//  AplicativoMapa
//
//  Created by André Gimenez Faria on 05/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "Configuracao.h"

@implementation Configuracao

@synthesize precoLitro;
@synthesize consumoLitro;
@synthesize gastoMaximo;
@synthesize preferenciaEstiloMapa;
@synthesize temaAlternativo;

-(Configuracao *) initWithConsumoLitro:(NSNumber *)cL eprecoLitro:(NSNumber *)pL egastoMaximo:(NSNumber *)gM ePreferenciaEstiloMapa:(NSString *)pEM eTemaAlternativo:(BOOL)tA {
    self = [super init];
    if (self) {
        consumoLitro = cL;
        precoLitro = pL;
        gastoMaximo = gM;
        preferenciaEstiloMapa = pEM;
        temaAlternativo = tA;
    }
    return self;
}
-(void) exibirConfiguracoes {
    NSLog(@"%@\n%@\n%@\n",consumoLitro,precoLitro,preferenciaEstiloMapa);
}

@end
