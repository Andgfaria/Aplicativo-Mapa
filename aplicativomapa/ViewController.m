//
//  ViewController.m
//  AplicativoMapa
//
//  Created by André Gimenez Faria on 05/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ViewController.h"
#import "GerenciadorConfiguracao.h"
#import "Configuracao.h"
#import <MapKit/MapKit.h>
#import <math.h>

@interface ViewController ()

@end

extern MKPlacemark *pl;

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    configuracoesSalvas = [[GerenciadorConfiguracao alloc] init];
    localizador = [[CLLocationManager alloc] init];
    [localizador setDesiredAccuracy:kCLLocationAccuracyBest];
    [localizador setDelegate:self];
    [_worldMap setShowsUserLocation:YES];
    
    [self setarEstiloMapa];
    
    [self setarTema];
    
    [_viewIndicadorAtividade.layer setCornerRadius:5];
    
    ultimaRotaPesquisada = nil;
    

    // Do any additional setup after loading the view, typically from a nib.
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocationCoordinate2D localizacaoAtual = [[locations lastObject] coordinate];
    MKCoordinateRegion regiao = MKCoordinateRegionMakeWithDistance(localizacaoAtual, 250, 250);
    [_worldMap setRegion:regiao animated:YES];
    [localizador stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)localizacaoAtual:(id)sender {
    [self mostrarIndicadorAtividade];
    [localizador startUpdatingLocation];
}

-(void) mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered {
    [self ocultarIndicadorAtividade];
}

-(void) setarTema {
    if ([[configuracoesSalvas retornarConfiguracoes] temaAlternativo]) {
        [self setarTemaAlternativo];
    }
    else [self setarTemaPadrao];
}

-(void) setarTemaAlternativo {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [_viewTopo setBackgroundColor:[UIColor whiteColor]];
    [_botaoConfiguracoes setTintColor:[UIColor orangeColor]];
    [_viewIndicadorAtividade setBackgroundColor:[UIColor whiteColor]];
    [_indicadorAtividade setColor:[UIColor orangeColor]];
    [_toolBar setBackgroundColor:[UIColor whiteColor]];
    [_botaoToolbar1 setTintColor:[UIColor orangeColor]];
    [_botaoToolbar2 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_botaoToolbar3 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_viewRotas setBackgroundColor:[UIColor whiteColor]];
    [_botaoTracarRotas setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_viewRotaUnica setBackgroundColor:[UIColor whiteColor]];
    [_botaoTracarRotaUnica setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_botaoRotaUnica setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_botaoInformacoesUltimaRota setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
}

-(void) setarTemaPadrao {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [_viewTopo setBackgroundColor:[UIColor orangeColor]];
    [_botaoConfiguracoes setTintColor:[UIColor whiteColor]];
    [_viewIndicadorAtividade setBackgroundColor:[UIColor orangeColor]];
    [_indicadorAtividade setColor:[UIColor whiteColor]];
    [_toolBar setBackgroundColor:[UIColor orangeColor]];
    [_botaoToolbar1 setTintColor:[UIColor whiteColor]];
    [_botaoToolbar2 setTintColor:[UIColor whiteColor]];
    [_botaoToolbar3 setTintColor:[UIColor whiteColor]];
    [_viewRotas setBackgroundColor:[UIColor orangeColor]];
    [_botaoTracarRotas setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_viewRotaUnica setBackgroundColor:[UIColor orangeColor]];
    [_botaoTracarRotaUnica setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_botaoRotaUnica setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_botaoInformacoesUltimaRota setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void) setarEstiloMapa {
    NSString *tipoMapa = [[configuracoesSalvas retornarConfiguracoes] preferenciaEstiloMapa];
    if ([tipoMapa isEqualToString:@"normal"]) {
        [_worldMap setMapType:MKMapTypeStandard];
    }
    else if ([tipoMapa isEqualToString:@"hibrido"]) {
        [_worldMap setMapType:MKMapTypeHybrid];
    }
    else [_worldMap setMapType:MKMapTypeSatellite];
}

- (IBAction)exibirSelecaoRotas:(id)sender {
    [_viewRotaUnica setHidden:YES];
    if ([_viewRotas isHidden]) {
        [_viewRotas setHidden:NO];
    }
    else [_viewRotas setHidden:YES];
}




- (IBAction)mostrarViewRotaUnica:(id)sender {
    [_viewRotas setHidden:YES];
    if ([_viewRotaUnica isHidden]) {
        [_viewRotaUnica setHidden:NO];
    }
    else [_viewRotaUnica setHidden:YES];
}

- (IBAction)tracarRotaUnica:(id)sender {
    [self tracarPontoUnico:[_entradaPontoX text]];
    [_viewRotaUnica setHidden:YES];
    [_entradaPontoX resignFirstResponder];
}

- (IBAction)limparRotas:(id)sender {
    [_worldMap removeAnnotations:[_worldMap annotations]];
    [_worldMap removeOverlays:[_worldMap overlays]];
    ultimaRotaPesquisada = nil;
    [_botaoInformacoesUltimaRota setEnabled:NO];
    [_botaoInformacoesUltimaRota setHidden:YES];
    [_botaoLimparRotas setHidden:YES];
}



-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)tracarRota:(id)sender {
    if ([[_entradaPontoA text] isEqualToString:@""] || [[_entradaPontoB text] isEqualToString:@""]) {
        UIAlertView *mensagemErro = [[UIAlertView alloc] initWithTitle:@"Campo(s) Vazio(s)" message:@"Os dois campos precisam receber um endereço para traçar uma rota." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [mensagemErro show];
    }
    else {
        [self mostrarIndicadorAtividade];

        [_viewRotas setHidden:YES];
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer =
    [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor orangeColor];
    renderer.lineWidth = 5.0;

    return renderer;
}

-(void) mostrarIndicadorAtividade {
    [_viewIndicadorAtividade setHidden:NO];
    [_indicadorAtividade setHidden:NO];
    [_indicadorAtividade startAnimating];
}

-(void) ocultarIndicadorAtividade {
    [_viewIndicadorAtividade setHidden:YES];
    [_indicadorAtividade setHidden:YES];
    [_indicadorAtividade stopAnimating];
}

-(CLLocation *) retornarLocalizacaoAtual {
    CLLocation *locAtual = [[CLLocation alloc] initWithLatitude:_worldMap.userLocation.coordinate.latitude longitude:_worldMap.userLocation.coordinate.longitude];
    return locAtual;
}

-(CLLocation *) converterMKMapItemParaCLLocation:(MKMapItem *)item {
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:item.placemark.coordinate.latitude longitude:item.placemark.coordinate.longitude];
    return loc;
}

-(void)tracarPontoUnico:(NSString *)endereco {
    [self mostrarIndicadorAtividade];
    [_botaoInformacoesUltimaRota setEnabled:NO];
    [_worldMap removeOverlays:[_worldMap overlays]];
    [_worldMap removeAnnotations:[_worldMap annotations]];
    MKLocalSearchRequest *request =
    [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = endereco;
    request.region = _worldMap.region;
    CLLocation *locAtual = [self retornarLocalizacaoAtual];
    CLLocation __block *pontoX;
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse
                                         *response, NSError *error) {
        if (response.mapItems.count == 0)
            NSLog(@"No Matches");
        else
        {
            MKPointAnnotation *annotation =
            [[MKPointAnnotation alloc] init];
            MKMapItem *mapItemO = [[response mapItems] objectAtIndex:0];
            CLLocation *localizacaoMaisPerto = [[CLLocation alloc] initWithLatitude:mapItemO.placemark.coordinate.latitude longitude:mapItemO.placemark.coordinate.longitude];
            for (MKMapItem *item in response.mapItems) {
                CLLocation *localizaoItem = [[CLLocation alloc] initWithLatitude:item.placemark.coordinate.latitude longitude:item.placemark.coordinate.latitude];
                if ([locAtual distanceFromLocation:localizacaoMaisPerto] > [locAtual distanceFromLocation:localizaoItem]) {
                    localizacaoMaisPerto = localizaoItem;
                    mapItemO = item;
                }
                pontoX = [self converterMKMapItemParaCLLocation:mapItemO];
            }
            annotation.title = endereco;
            [annotation setCoordinate:mapItemO.placemark.coordinate];
            [_worldMap addAnnotation:annotation];
            [self pegarDirecoesAPartirDaLocalizacaoAtual:mapItemO];
            [self atualizarUltimaRotaComPontoA:locAtual ePontoB:pontoX];
            [self atualizarInformacoesDaUltimaRota];
            [_botaoInformacoesUltimaRota setEnabled:YES];
            [_botaoInformacoesUltimaRota setHidden:NO];
            [_botaoLimparRotas setHidden:NO];
            [self ocultarIndicadorAtividade];
        }
    }];
    
}

- (void)pegarDirecoesAPartirDaLocalizacaoAtual:(MKMapItem *)destino
{
    MKDirectionsRequest *request =
    [[MKDirectionsRequest alloc] init];
    request.source = [MKMapItem mapItemForCurrentLocation];
    request.destination = destino;
    request.requestsAlternateRoutes = NO;
    MKDirections *directions =
    [[MKDirections alloc] initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:
     ^(MKDirectionsResponse *response, NSError *error) {
         if (error) {
             UIAlertView *popUpErro = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Não foi possível calcular a rota." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [popUpErro show];
         } else {
             NSLog(@"Entrei aqui");
             [self showRoute:response];
         }
     }];
}

-(void)showRoute:(MKDirectionsResponse *)response
{
    for (MKRoute *route in response.routes)
    {
        [_worldMap
         addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
    }
}

-(void) atualizarUltimaRotaComPontoA:(CLLocation *)pA ePontoB:(CLLocation *)pB {
    if (ultimaRotaPesquisada == nil) {
        ultimaRotaPesquisada = [[Rota alloc] initWithPontoA:pA ePontoB:pB];
    }
    else {
        [ultimaRotaPesquisada setPontoA:pA];
        [ultimaRotaPesquisada setPontoB:pB];
    }
}

-(void) atualizarInformacoesDaUltimaRota {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:3];
    NSMutableString *distancia = [[NSMutableString alloc] initWithString:@"Distância: "];
    [distancia appendString:[formatter stringFromNumber:[ultimaRotaPesquisada calcularDistancia]]];
    [distancia appendString:@" Km"];
    [_txtDistanciaUltimaRota setText:distancia];
    NSMutableString *custo = [[NSMutableString alloc] initWithString:@"Custo: R"];
    [formatter setMaximumFractionDigits:2];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [custo appendString:[formatter stringFromNumber:[ultimaRotaPesquisada calcularCusto]]];
    double diferencaGastoMaximo = [[[configuracoesSalvas retornarConfiguracoes] gastoMaximo] doubleValue] -  [[ultimaRotaPesquisada calcularCusto] doubleValue];
    if (diferencaGastoMaximo < 0) {
        NSMutableString *limiteExcedido = [[NSMutableString alloc] initWithString:@"Limite excedido em: R"];
        NSNumber *n = [[NSNumber alloc] initWithDouble:fabs(diferencaGastoMaximo)];
        [limiteExcedido appendString:[formatter stringFromNumber:n]];
        [_txtLimiteExcedido setText:limiteExcedido];
        [_txtLimiteExcedido setHidden:NO];
    }
    else [_txtLimiteExcedido setHidden:YES];
    [_txtCustoUltimaRota setText:custo];
}

-(void) resetarUltimaRota {
    ultimaRotaPesquisada = nil;
    [_botaoInformacoesUltimaRota setHidden:YES];
    [_botaoInformacoesUltimaRota setEnabled:NO];
}

- (IBAction)ocultarInformacoesUltimaRota:(id)sender {
    [_informacoesUltimaRota setHidden:YES];
}
- (IBAction)exibirInformacoesUltimaRota:(id)sender {
    [_informacoesUltimaRota setHidden:NO];
}
@end
