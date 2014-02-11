//
//  Rota.m
//  aplicativomapa
//
//  Created by André Gimenez Faria on 09/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "Rota.h"

@implementation Rota

-(Rota *) initWithPontoA:(CLLocation *)pA ePontoB:(CLLocation *)pB {
    self = [super init];
    if (self) {
        pontoA = pA;
        pontoB = pB;
    }
    return self;
}

-(NSNumber *) calcularDistancia {
    NSNumber *distancia = [[NSNumber alloc] initWithDouble:[pontoA distanceFromLocation:pontoB]];
    return distancia;
}

-(NSNumber *) calcularCusto {
    GerenciadorConfiguracao *configuracoes = [[GerenciadorConfiguracao alloc] init];
    NSNumber *custo = [[NSNumber alloc] initWithDouble:(([[self calcularDistancia] doubleValue] / [[[configuracoes retornarConfiguracoes] consumoLitro] doubleValue]) * [[[configuracoes retornarConfiguracoes] precoLitro] doubleValue] / 10)];
    return custo;
}

@end
