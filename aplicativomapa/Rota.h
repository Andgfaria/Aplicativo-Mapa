//
//  Rota.h
//  aplicativomapa
//
//  Created by André Gimenez Faria on 09/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "GerenciadorConfiguracao.h"
#import "Configuracao.h"

@interface Rota : NSObject {
    CLLocation *pontoA;
    CLLocation *pontoB;
}

-(Rota *) initWithPontoA:(CLLocation *)pA ePontoB:(CLLocation *)pB;
-(NSNumber *) calcularDistancia;
-(NSNumber *) calcularCusto;
-(void) imprimirEnderecos;

@property CLLocation *pontoA;
@property CLLocation *pontoB;

@end
