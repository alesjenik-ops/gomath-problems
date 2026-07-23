String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD22C0T04';
Integer YEAR = 2022;

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; String ccode; Integer yr; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype, String ccode, Integer yr){this.tx=tx;this.have=have;this.src=src;this.stype=stype;this.ccode=ccode;this.yr=yr;}
  Id sv(String t,String fn,String s){ContentVersion cv=new ContentVersion(Title=t,PathOnClient=fn,VersionData=Blob.valueOf(s),Origin='H');insert cv;return [SELECT ContentDocumentId FROM ContentVersion WHERE Id=:cv.Id].ContentDocumentId;}
  void lk(Id d,Id r){try{insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='AllUsers');}catch(Exception e){insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='InternalUsers');}}
  String para(String t){return '{"type":"paragraph","text":'+JSON.serialize(t)+'}';}
  String content(List<String> zad, Id d, String alt, String cap, List<String> opts, Integer ln){
    String s='{"schemaVersion":1,"blocks":[';
    for(Integer i=0;i<zad.size();i++){if(i>0)s+=',';s+=para(zad[i]);}
    if(d!=null){s+=',{"type":"image","contentDocumentId":"'+d+'","alt":'+JSON.serialize(alt)+',"caption":'+JSON.serialize(cap)+',"widthPercent":75,"align":"center"}';}
    if(opts!=null && !opts.isEmpty()){s+=',{"type":"list","items":[';for(Integer i=0;i<opts.size();i++){if(i>0)s+=',';s+=JSON.serialize(opts[i]);}s+=']}';}
    if(ln!=null && ln>0){s+=',{"type":"answerSpace","lines":'+ln+'}';}
    s+=']}';return s;
  }
  String solution(List<String> ps){String s='{"schemaVersion":1,"blocks":[';for(Integer i=0;i<ps.size();i++){if(i>0)s+=',';s+=para(ps[i]);}s+=']}';return s;}
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,CERMAT_Code__c=ccode,Source_Year__c=yr,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
    insert pub;
    List<Problem_Taxon__c> ls=new List<Problem_Taxon__c>();
    for(String code:codes){Id ti=tx.get(code);if(ti==null)continue;ls.add(new Problem_Taxon__c(Problem_Version__c=pub.Id,Taxon__c=ti,Unique_Key__c=pub.Id+'_'+ti));}
    if(!ls.isEmpty())insert ls;
    if(d!=null)lk(d,mp.Id);
    created++;
  }
}
Map<String,Id> tx=new Map<String,Id>();
for(Taxon__c t:[SELECT Id,Code__c FROM Taxon__c])tx.put(t.Code__c,t.Id);
Set<String> have=new Set<String>();
for(Math_Problem__c p:[SELECT Name FROM Math_Problem__c])have.add(p.Name);
C c=new C(tx,have,SRC,STYPE,CCODE,YEAR);

c.add(
  'CERMAT M5D 2022 – úloha 7.1 (konstrukce)',
  new List<String>{'V rovině leží přímky $a$, $b$, které se protínají v bodě $C$. Na přímce $b$ leží bod $M$ (viz obrázek).','Bod $C$ je vrchol obdélníku $ABCD$. Vrchol $A$ tohoto obdélníku leží na přímce $a$. Úsečka $AM$ je dvakrát delší než úsečka $CM$. Vrchol $B$ obdélníku $ABCD$ leží na přímce $b$.','Sestrojte vrcholy $A$, $B$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif"> <line x1="40" y1="234" x2="430" y2="156" stroke="#000" stroke-width="2"/> <text x="437" y="154" font-size="16" font-style="italic">a</text> <line x1="150" y1="284" x2="290" y2="88" stroke="#000" stroke-width="2"/> <text x="295" y="82" font-size="16" font-style="italic">b</text> <circle cx="210" cy="200" r="3" fill="#000"/> <text x="198" y="218" font-size="15" font-style="italic">C</text> <circle cx="250" cy="144" r="3" fill="#000"/> <text x="258" y="140" font-size="15" font-style="italic">M</text> <line x1="245" y1="134" x2="255" y2="154" stroke="#000" stroke-width="2"/> </svg>',
  'primky-ab.svg',
  'Dvě přímky a a b protínající se v bodě C; na přímce b leží bod M.',
  'Výchozí obrázek k úloze 7.1',
  new List<String>{'Strana $BC$ leží na přímce $b$ (obsahuje body $B$ i $C$), proto je strana $AB$ kolmá k přímce $b$ a vrchol $A$ leží na přímce $a$. Bod $A$ určíme z podmínky $|AM| = 2\\cdot|CM|$: sestrojíme kružnici se středem $M$ a poloměrem $2\\cdot|CM|$; její dva průsečíky s přímkou $a$ jsou vrcholy $A_1$, $A_2$. Z každého bodu $A$ spustíme kolmici na přímku $b$ (pata je vrchol $B$) a doplníme obdélník. Úloha má dvě řešení.'},
  'Dvě řešení: obdélníky $A_1BCD_1$ a $A_2BCD_2$; vrchol $A$ leží na přímce $a$ a splňuje $|AM| = 2\\cdot|CM|$, strana $BC$ leží na přímce $b$ (viz obrázek v klíči).',
  3, 7, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2022 – úloha 7.2 (konstrukce)',
  new List<String>{'V rovině leží bod $F$ a různoběžné přímky $g$, $h$ (viz obrázek).','Bod $F$ je vrchol trojúhelníku $FGH$. Na přímce $g$ leží vrchol $G$, na přímce $h$ leží vrchol $H$. Obě strany $FG$ i $GH$ mají stejnou délku, a to $5$ cm.','Sestrojte vrcholy $G$, $H$ trojúhelníku $FGH$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"> <line x1="40" y1="205" x2="430" y2="120" stroke="#000" stroke-width="2"/> <text x="437" y="118" font-size="16" font-style="italic">g</text> <line x1="60" y1="120" x2="380" y2="285" stroke="#000" stroke-width="2"/> <text x="386" y="292" font-size="16" font-style="italic">h</text> <text x="322" y="234" font-size="15" font-style="italic">F</text> <text x="318" y="222" font-size="15">×</text> </svg>',
  'body-F-gh.svg',
  'Bod F a dvě různoběžné přímky g a h.',
  'Výchozí obrázek k úloze 7.2',
  new List<String>{'Vrchol $G$ leží na přímce $g$ a zároveň $|FG| = 5$ cm, proto jej najdeme jako průsečík přímky $g$ s kružnicí se středem $F$ a poloměrem $5$ cm. Vrchol $H$ leží na přímce $h$ a $|GH| = 5$ cm, proto jej najdeme jako průsečík přímky $h$ s kružnicí se středem $G$ a poloměrem $5$ cm; ta protíná přímku $h$ ve dvou bodech $H_1$, $H_2$. Úloha má dvě řešení – trojúhelníky $FGH_1$ a $FGH_2$.'},
  'Dvě řešení: $G$ na přímce $g$ ve vzdálenosti $5$ cm od $F$; body $H_1$, $H_2$ na přímce $h$ ve vzdálenosti $5$ cm od $G$ (trojúhelníky $FGH_1$, $FGH_2$) – viz obrázek v klíči.',
  3, 7, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
