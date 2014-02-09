//
//  ViewConfiguracoes.h
//  AplicativoMapa
//
//  Created by André Gimenez Faria on 06/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Configuracao.h"
#import "GerenciadorConfiguracao.h"

@interface ViewConfiguracoes : UIViewController {
    GerenciadorConfiguracao *gerenciador;
    Configuracao *configuracaoAtual;
    int flag;
}
@property (weak, nonatomic) IBOutlet UITextField *entradaConsumo;
@property (weak, nonatomic) IBOutlet UITextField *entradaPreco;
@property (weak, nonatomic) IBOutlet UITextField *entradaGasto;
@property (weak, nonatomic) IBOutlet UISegmentedControl *seletorEstiloMapa;
@property (weak, nonatomic) IBOutlet UIButton *botaoOk;
@property (weak, nonatomic) IBOutlet UIView *viewTopo;
@property (weak, nonatomic) IBOutlet UISwitch *botaoMudarTema;

- (IBAction)mudarConfiguracoes:(id)sender;
- (IBAction)mudarTema:(id)sender;

-(ViewConfiguracoes *) init;

@property int flag;

@end
