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
    double d = [pontoA distanceFromLocation:pontoB];
    NSNumber *distancia = [[NSNumber alloc] initWithDouble:(d/1000)];
    return distancia;
}

-(NSNumber *) calcularCusto {
    GerenciadorConfiguracao *configuracoes = [[GerenciadorConfiguracao alloc] init];
    NSNumber *custo = [[NSNumber alloc] initWithDouble:(([[self calcularDistancia] doubleValue] / [[[configuracoes retornarConfiguracoes] consumoLitro] doubleValue]) * [[[configuracoes retornarConfiguracoes] precoLitro] doubleValue])];
    return custo;
}

-(void) imprimirEnderecos {
    NSLog(@"Ponto a: %@\n Ponto b: %@ ",pontoA,pontoB);
}

@end
