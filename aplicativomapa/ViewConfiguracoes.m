//
//  ViewConfiguracoes.m
//  AplicativoMapa
//
//  Created by André Gimenez Faria on 06/02/14.
//  Copyright (c) 2014 BEPiD. All rights reserved.
//

#import "ViewConfiguracoes.h"

@interface ViewConfiguracoes ()

@end


@implementation ViewConfiguracoes

@synthesize flag;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self carregarConfiguracoes];
    [_seletorEstiloMapa addTarget:self action:@selector(modificarEstiloMapa) forControlEvents:UIControlEventValueChanged];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void) carregarConfiguracoesNovas {
    gerenciador = [[GerenciadorConfiguracao alloc]init];
    configuracaoAtual = [[Configuracao alloc] init];
    [gerenciador carregarConfiguracoesPadrao];
    configuracaoAtual = [gerenciador retornarConfiguracoes];
    [_entradaConsumo setText:[[configuracaoAtual consumoLitro] stringValue]];
    [_entradaPreco setText:[[configuracaoAtual precoLitro] stringValue]];
    [_entradaGasto setText:[[configuracaoAtual gastoMaximo] stringValue]];
    NSString *opcaoMapa = [configuracaoAtual preferenciaEstiloMapa];
    if ([opcaoMapa  isEqual: @"normal"]) {
        [_seletorEstiloMapa setSelectedSegmentIndex:0];
    }
    else if ([opcaoMapa isEqual:@"hibrido"]) {
        [_seletorEstiloMapa setSelectedSegmentIndex:1];
    }
    else {
        [_seletorEstiloMapa setSelectedSegmentIndex:2];
    }
}

-(void) carregarConfiguracoes {
    gerenciador = [[GerenciadorConfiguracao alloc] init];
    configuracaoAtual = [[Configuracao alloc] init];
    configuracaoAtual = [gerenciador retornarConfiguracoes];
    [configuracaoAtual exibirConfiguracoes];
    [_entradaConsumo setText:[[configuracaoAtual consumoLitro] stringValue]];
    [_entradaPreco setText:[[configuracaoAtual precoLitro] stringValue]];
    [_entradaGasto setText:[[configuracaoAtual gastoMaximo] stringValue]];
    NSString *opcaoMapa = [configuracaoAtual preferenciaEstiloMapa];
    if ([opcaoMapa  isEqual: @"normal"]) {
        [_seletorEstiloMapa setSelectedSegmentIndex:0];
    }
    else if ([opcaoMapa isEqual:@"hibrido"]) {
        [_seletorEstiloMapa setSelectedSegmentIndex:1];
    }
    else {
        [_seletorEstiloMapa setSelectedSegmentIndex:2];
    }
    if ([configuracaoAtual temaAlternativo]) {
        [self setarTemaAlternativo];
        [_botaoMudarTema setOn:YES];
    }
    else {
        [self setarTemaPadrao];
        [_botaoMudarTema setOn:NO];
    }

}

-(void) setarTemaAlternativo {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [_viewTopo setBackgroundColor:[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:0.9]];
    [_botaoOk setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
}

-(void) setarTemaPadrao {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [_viewTopo setBackgroundColor:[UIColor orangeColor]];
    [_botaoOk setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [configuracaoAtual setPrecoLitro:[formatter numberFromString:[_entradaPreco text]]];
    [configuracaoAtual setConsumoLitro:[formatter numberFromString:[_entradaConsumo text]]];
    [configuracaoAtual setGastoMaximo:[formatter numberFromString:[_entradaGasto text]]];
    [textField resignFirstResponder];
    return YES;
}

-(void) modificarEstiloMapa {
    if ([_seletorEstiloMapa selectedSegmentIndex] == 0) {
        [configuracaoAtual setPreferenciaEstiloMapa:@"normal"];
    }
    else if ([_seletorEstiloMapa selectedSegmentIndex] == 1) {
        [configuracaoAtual setPreferenciaEstiloMapa:@"hibrido"];
    }
    else [configuracaoAtual setPreferenciaEstiloMapa:@"satelite"];
}

- (IBAction)mudarConfiguracoes:(id)sender {
    [gerenciador armazenarConfiguracoes:configuracaoAtual];
}

- (IBAction)mudarTema:(id)sender {
    if ([sender isOn]) {
        [configuracaoAtual setTemaAlternativo:YES];
        [self setarTemaAlternativo];
    }
    else {
        [configuracaoAtual setTemaAlternativo:NO];
        [self setarTemaPadrao];
    }
}
@end
