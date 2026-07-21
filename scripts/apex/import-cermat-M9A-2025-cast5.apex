String SRC   = 'CERMAT – Jednotná přijímací zkouška 2025, 1. řádný termín (M9A)';
String STYPE = 'CERMAT';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'CERMAT 2025 M9A · úloha 9',
  new List<String>{'V rovině leží různoběžky $p$, $q$ a bod $R$ (viz obrázek).','9.1 Sestrojte osu většího úhlu, který svírají přímky $p$, $q$, a označte ji písmenem $o$.','9.2 Na přímkách $p$, $q$ leží všechny čtyři vrcholy obdélníku $KLMN$; bod $R$ leží uvnitř strany $MN$. Sestrojte vrcholy obdélníku $KLMN$, označte je a obdélník narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 472 291"><path d="M4 18L5 18L5 19L4 19Z" style="fill:#000000"/><path d="M4 18L5 18L5 19L4 19Z" style="fill:#000000"/><path d="M5 18L467 18L467 19L5 19Z" style="fill:#000000"/><path d="M467 18L468 18L468 19L467 19Z" style="fill:#000000"/><path d="M467 18L468 18L468 19L467 19Z" style="fill:#000000"/><path d="M4 19L5 19L5 38L4 38Z" style="fill:#000000"/><path d="M467 19L468 19L468 38L467 38Z" style="fill:#000000"/><path d="M4 286L5 286L5 287L4 287Z" style="fill:#000000"/><path d="M4 286L5 286L5 287L4 287Z" style="fill:#000000"/><path d="M5 286L467 286L467 287L5 287Z" style="fill:#000000"/><path d="M467 286L468 286L468 287L467 287Z" style="fill:#000000"/><path d="M467 286L468 286L468 287L467 287Z" style="fill:#000000"/><path d="M4 38L5 38L5 286L4 286Z" style="fill:#000000"/><path d="M467 38L468 38L468 286L467 286Z" style="fill:#000000"/><path d="M52 209L378 126M87 55L299 268M176 107L182 113M182 107L176 113" style="fill:none;stroke:#000000;stroke-width:2"/><text x="111" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">VÝCHOZÍ TEXT A OBRÁZEK K ÚLOZE 9</text><text x="71" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V rovině leží různoběžky</text><text x="136" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text><text x="142" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="147" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">q</text><text x="167" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a bod</text><text x="187" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">R</text><text x="193" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="374" y="141" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text><text x="85" y="69" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">q</text><text x="179" y="127" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">R</text></svg>',
  'obr.svg',
  'Různoběžky p, q a bod R v rovině.',
  '',
  new List<String>{'9.1: osu $o$ většího úhlu sestrojíme jako osu úhlu dvou různoběžek (množina bodů stejně vzdálených od $p$ i $q$).','9.2: obdélník $KLMN$ vepsaný do úhlu je souměrný podle osy $o$; strana $MN$ je kolmá k $o$ a prochází bodem $R$. Z bodu $R$ vedeme kolmici k $o$ (strana $MN$), její průsečíky s $p$, $q$ jsou $M$, $N$; osovou souměrností podle $o$, resp. kolmicemi, dostaneme $K$, $L$.'},
  'Osa $o$ většího úhlu; obdélník $KLMN$ souměrný podle $o$ se stranou $MN\\perp o$ procházející bodem $R$ (viz konstrukce).',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','geometrie','planimetrie','konstrukcni','rysovani','bez-kontextu'},
  'M9PAD25C0T01', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
