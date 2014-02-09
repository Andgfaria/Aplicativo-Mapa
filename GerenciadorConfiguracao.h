//
//  GerenciadorConfiguracao.h
//  AplicativoMapa
//
//  Created by André Gimenez Faria on 05/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Configuracao;

@interface GerenciadorConfiguracao : NSObject {
    NSUserDefaults *configuracoesSalvas;
}

-(GerenciadorConfiguracao *) init;
-(void) carregarConfiguracoesPadrao;
-(Configuracao *) retornarConfiguracoes;
-(void)armazenarConfiguracoes:(Configuracao *)configuracoes;


@end
