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
#import "GerenciadorConfiguracao.h"
#import "Rota.h"

@interface ViewController : UIViewController {
    CLLocationManager *localizador;
    GerenciadorConfiguracao *configuracoesSalvas;
    MKMapItem *ponto;
    Rota *ultimaRotaPesquisada;
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

@property (weak, nonatomic) IBOutlet UIView *viewRotas;
@property (weak, nonatomic) IBOutlet UIButton *botaoTracarRotas;
- (IBAction)exibirSelecaoRotas:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *botaoRotaUnica;
@property (weak, nonatomic) IBOutlet UIView *viewRotaUnica;
@property (weak, nonatomic) IBOutlet UIButton *botaoTracarRotaUnica;
@property (weak, nonatomic) IBOutlet UITextField *entradaPontoX;

- (IBAction)mostrarViewRotaUnica:(id)sender;
- (IBAction)tracarRotaUnica:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *botaoLimparRotas;

- (IBAction)limparRotas:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewIndicadorAtividade;

@property (weak, nonatomic) IBOutlet UIView *informacoesUltimaRota;
@property (weak, nonatomic) IBOutlet UIButton *botaoInformacoesUltimaRota;


@property (weak, nonatomic) IBOutlet UILabel *txtDistanciaUltimaRota;
- (IBAction)exibirInformacoesUltimaRota:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *txtCustoUltimaRota;

@property (weak, nonatomic) IBOutlet UILabel *txtLimiteExcedido;

- (IBAction)ocultarInformacoesUltimaRota:(id)sender;


@end
