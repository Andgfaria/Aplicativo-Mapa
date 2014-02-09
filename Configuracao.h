//
//  Configuracao.h
//  AplicativoMapa
//
//  Created by André Gimenez Faria on 05/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Configuracao : NSObject {
    NSNumber *consumoLitro;
    NSNumber *precoLitro;
    NSNumber *gastoMaximo;
    NSString *preferenciaEstiloMapa;
    BOOL temaAlternativo;
}

@property NSNumber *consumoLitro;
@property NSNumber *precoLitro;
@property NSNumber *gastoMaximo;
@property NSString *preferenciaEstiloMapa;
@property BOOL temaAlternativo;

-(Configuracao *) initWithConsumoLitro:(NSNumber *) cL eprecoLitro:(NSNumber *)pL egastoMaximo:(NSNumber *)gM ePreferenciaEstiloMapa:(NSString *)pEM eTemaAlternativo:(BOOL)tA;
-(void) exibirConfiguracoes;

@end
