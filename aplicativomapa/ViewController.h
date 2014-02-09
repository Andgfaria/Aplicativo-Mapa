//
//  ViewController.h
//  AplicativoMapa
//
//  Created by André Gimenez Faria on 05/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#include "GerenciadorConfiguracao.h"

@interface ViewController : UIViewController {
    CLLocationManager *localizador;
    GerenciadorConfiguracao *configuracoesSalvas;
    MKMapItem *ponto;
    CLLocationDistance *distanciaUltimaRota;
    double custoUltimaRota;
}
@property (weak, nonatomic) IBOutlet MKMapView *worldMap;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicadorAtividade;
- (IBAction)localizacaoAtual:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewTopo;
@property (weak, nonatomic) IBOutlet UIButton *botaoConfiguracoes;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *botaoToolbar1;
@property (weak, nonatomic) IBOutlet UIButton *botaoToolbar2;
@property (weak, nonatomic) IBOutlet UIButton *botaoToolbar3;
@property (weak, nonatomic) IBOutlet UITextField *entradaPontoA;
@property (weak, nonatomic) IBOutlet UITextField *entradaPontoB;
- (IBAction)rotaUnica:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewRotas;
@property (weak, nonatomic) IBOutlet UIButton *botaoTracarRotas;
- (IBAction)exibirSelecaoRotas:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *botaoRotaUnica;
@property (weak, nonatomic) IBOutlet UIView *viewRotaUnica;
@property (weak, nonatomic) IBOutlet UIButton *botaoTracarRotaUnica;
@property (weak, nonatomic) IBOutlet UITextField *entradaPontoX;

- (IBAction)mostrarViewRotaUnica:(id)sender;
- (IBAction)tracarRotaUnica:(id)sender;

- (IBAction)limparAnotacoes:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewIndicadorAtividade;

-(void) mostrarIndicadorAtividade;
-(void) ocultarIndicadoratividade;

@end
