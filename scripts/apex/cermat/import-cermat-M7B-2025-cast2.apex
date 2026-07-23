String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD25C0T02';
Integer YEAR = 2025;

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
  'CERMAT M7B 2025 – úloha 5',
  new List<String>{'Všichni žáci třídy se rozdělili na dvě stejně početné skupiny. Žáci první skupiny vytvořili dvojice a žáci druhé skupiny trojice. V každé skupině však jeden žák zbyl. Tito dva žáci spolu nakonec vytvořili ještě jednu dvojici. Všech dvojic tak bylo o 3 více než trojic.','5.1 Určete počet všech vytvořených dvojic.','5.2 Určete počet všech žáků ve třídě.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Počet žáků v jedné skupině je tvaru $2a+1=3b+1$ (jeden žák vždy zbyde), odtud $2a=3b$. Dvojic je $a+1$ (včetně poslední dvojice ze dvou zbylých), trojic je $b$. Z rovnic $\\left(a+1\\right)-b=3$ a $2a=3b$ vyjde $b=4$, $a=6$.','5.1 Dvojic je $a+1=7$.','5.2 V každé skupině je $2\\cdot 6+1=13$ žáků, celkem $2\\cdot 13=26$ žáků.'},
  '5.1: $7$ dvojic; 5.2: $26$ žáků',
  3, 5, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2025 – úloha 6',
  new List<String>{'Operace $M$ (zmenšení čísla) se provádí takto: v zápisu čísla se zleva doprava mezi každé dvě sousední číslice zapíšou střídavě znaménka $-$ a $+$, potom se provede výpočet. Pro operaci $M$ vybíráme pouze kladná celá čísla složená ze vzájemně různých číslic. Například $M(29\\,087)=2-9+0-8+7=-8$.','6.1 Vypočtěte $M(18\\,059)$.','6.2 Určete největší pěticiferné číslo, jehož zmenšením $M$ získáme číslo 1.','6.3 Určete nejmenší čtyřciferné číslo, jehož zmenšením $M$ získáme číslo $-1$.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 $M(18\\,059)=1-8+0-5+9=-3$.','6.2 Hledáme největší číslo s různými ciframi a součtem $a-b+c-d+e=1$. Volíme $a=9$, $b=8$: pak $c-d+e=0$; největší je $c=6$, $d=7$, $e=1$. Číslo je $98\\,671$.','6.3 Hledáme nejmenší číslo s $a-b+c-d=-1$. Volíme $a=1$, $b=0$: pak $c-d=-2$; nejmenší je $c=2$, $d=4$. Číslo je $1024$.'},
  '6.1: $-3$; 6.2: $98\\,671$; 6.3: $1024$',
  3, 6, '4',
  new List<String>{'zs2','r7','aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2025 – úloha 7',
  new List<String>{'Podstavou kolmého čtyřbokého hranolu je rovnoramenný lichoběžník. V tomto lichoběžníku delší základna měří 11 cm a výška 4 cm. Největší boční stěnou hranolu je obdélník o obsahu 55 cm², zbývající tři boční stěny jsou shodné čtverce.','7.1 Vypočtěte v cm výšku hranolu.','7.2 Vypočtěte v cm obvod podstavy hranolu.','7.3 Vypočtěte v cm² obsah podstavy hranolu.','7.4 Vypočtěte v cm³ objem hranolu.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 250" font-family="sans-serif"> <polygon points="60,200 300,200 260,120 100,120" fill="#f2f2f2" stroke="#000" stroke-width="2"/> <polygon points="300,200 380,170 340,90 260,120" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/> <polygon points="100,120 260,120 340,90 180,90" fill="#eeeeee" stroke="#000" stroke-width="1.5"/> <line x1="290" y1="182" x2="358" y2="152" stroke="#000" stroke-width="1.1" stroke-dasharray="4 3"/> <text x="308" y="146" font-size="14">11 cm</text> <line x1="300" y1="200" x2="300" y2="120" stroke="#000" stroke-width="1" stroke-dasharray="3 3"/> <text x="236" y="172" font-size="14">4 cm</text> </svg>',
  'hranol.svg',
  'Kolmý čtyřboký hranol s podstavou rovnoramenného lichoběžníku; delší základna 11 cm, výška lichoběžníku 4 cm.',
  'Schematický nákres hranolu',
  new List<String>{'7.1 Největší boční stěna odpovídá delší základně 11 cm: $11\\cdot v=55$, tedy výška hranolu $v=5$ cm.','7.2 Tři shodné čtvercové stěny mají stranu 5 cm, proto zbývající tři strany lichoběžníku (dvě ramena a kratší základna) měří 5 cm. Obvod podstavy $=11+5+5+5=26$ cm.','7.3 Obsah lichoběžníku $=\\frac{11+5}{2}\\cdot 4=32$ cm².','7.4 Objem $=32\\cdot 5=160$ cm³.'},
  '7.1: $5$ cm; 7.2: $26$ cm; 7.3: $32$ cm²; 7.4: $160$ cm³',
  4, 7, '3',
  new List<String>{'zs2','r7','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
