String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD17C0T02';
Integer YEAR = 2017;

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
  'CERMAT M7B 2017 – úloha 12',
  new List<String>{'Tmavý obrazec ve čtvercové síti se skládá ze dvou trojúhelníků. Strana čtverce sítě měří $5$ cm.','Jaký je obsah tmavého obrazce?'},
  new List<String>{'A) $37{,}5$ cm²','B) $38$ cm²','C) $38{,}5$ cm²','D) $39$ cm²','E) jiný obsah'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 200" font-family="sans-serif"><polygon points="168,24 216,43 168,120" fill="#b8b8b8" stroke="#000" stroke-width="2"/><polygon points="168,72 168,120 120,86" fill="#b8b8b8" stroke="#000" stroke-width="2"/><line x1="24" y1="24" x2="24" y2="168" stroke="#777" stroke-width="1.5"/><line x1="72" y1="24" x2="72" y2="168" stroke="#777" stroke-width="1.5"/><line x1="120" y1="24" x2="120" y2="168" stroke="#777" stroke-width="1.5"/><line x1="168" y1="24" x2="168" y2="168" stroke="#777" stroke-width="1.5"/><line x1="216" y1="24" x2="216" y2="168" stroke="#777" stroke-width="1.5"/><line x1="264" y1="24" x2="264" y2="168" stroke="#777" stroke-width="1.5"/><line x1="312" y1="24" x2="312" y2="168" stroke="#777" stroke-width="1.5"/><line x1="360" y1="24" x2="360" y2="168" stroke="#777" stroke-width="1.5"/><line x1="408" y1="24" x2="408" y2="168" stroke="#777" stroke-width="1.5"/><line x1="24" y1="24" x2="408" y2="24" stroke="#777" stroke-width="1.5"/><line x1="24" y1="72" x2="408" y2="72" stroke="#777" stroke-width="1.5"/><line x1="24" y1="120" x2="408" y2="120" stroke="#777" stroke-width="1.5"/><line x1="24" y1="168" x2="408" y2="168" stroke="#777" stroke-width="1.5"/><line x1="96" y1="26" x2="96" y2="70" stroke="#000" stroke-width="1.5"/><polygon points="96,22 92,32 100,32" fill="#000"/><polygon points="96,74 92,64 100,64" fill="#000"/><text x="88" y="54" font-size="14" text-anchor="end">5 cm</text><line x1="314" y1="48" x2="358" y2="48" stroke="#000" stroke-width="1.5"/><polygon points="310,48 320,44 320,52" fill="#000"/><polygon points="362,48 352,44 352,52" fill="#000"/><text x="336" y="38" font-size="14" text-anchor="middle">5 cm</text></svg>',
  'sit-trojuhelniky.svg',
  'Čtvercová síť se čtvercem o straně 5 cm; tmavý obrazec tvoří dva trojúhelníky se společným vrcholem.',
  'Tmavý obrazec ve čtvercové síti',
  new List<String>{'Větší trojúhelník má svislou stranu dlouhou dva čtverce, tj. $10$ cm, a výšku k ní jeden čtverec, tj. $5$ cm: $S_1=\\frac{10\\cdot 5}{2}=25$ cm².','Menší trojúhelník má svislou stranu $5$ cm a výšku $5$ cm: $S_2=\\frac{5\\cdot 5}{2}=12{,}5$ cm².','Celkem $25+12{,}5=37{,}5$ cm².'},
  'A) $37{,}5$ cm²',
  2, 4, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2017 – úloha 13',
  new List<String>{'Čtyřúhelník $ABCD$ se skládá z rovnostranného trojúhelníku $ABC$ (strany $a$) a rovnoramenného trojúhelníku $ACD$ (ramena $b$). Vnitřní úhel čtyřúhelníku při vrcholu $C$ měří $133^\\circ$.','Jaká je velikost úhlu $\\delta$ při vrcholu $D$? Úhel $\\delta$ neměřte, ale vypočtěte.'},
  new List<String>{'A) menší než $34^\\circ$','B) $34^\\circ$','C) $36^\\circ$','D) $37^\\circ$','E) větší než $37^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 350" font-family="sans-serif"> <polygon points="147,75 308,201 319,321 210,270" fill="none" stroke="#000" stroke-width="2.5"/> <line x1="210" y1="270" x2="308" y2="201" stroke="#000" stroke-width="1.5"/> <text x="128" y="70" font-size="17" font-style="italic">D</text> <text x="318" y="196" font-size="17" font-style="italic">C</text> <text x="330" y="333" font-size="17" font-style="italic">B</text> <text x="192" y="286" font-size="17" font-style="italic">A</text> <text x="228" y="128" font-size="16" font-style="italic">b</text> <text x="160" y="185" font-size="16" font-style="italic">b</text> <text x="326" y="264" font-size="16" font-style="italic">a</text> <text x="258" y="312" font-size="16" font-style="italic">a</text> <path d="M175 100 A 40 40 0 0 0 165 118" fill="none" stroke="#000"/> <text x="164" y="104" font-size="15">δ</text> <path d="M278 214 A 40 40 0 0 0 296 246" fill="none" stroke="#000"/> <text x="262" y="234" font-size="14">133°</text> </svg>',
  'ctyruhelnik-ABCD.svg',
  'Čtyřúhelník ABCD složený z rovnostranného trojúhelníku ABC se stranami a a rovnoramenného trojúhelníku ACD s rameny b; u vrcholu C je vyznačen úhel 133 stupňů, u vrcholu D úhel delta.',
  'Čtyřúhelník ABCD',
  new List<String>{'V rovnostranném trojúhelníku $ABC$ je úhel $ACB=60^\\circ$.','Proto úhel $ACD=133^\\circ-60^\\circ=73^\\circ$.','Trojúhelník $ACD$ je rovnoramenný s rameny $b=|AD|=|CD|$, takže úhly při základně $AC$ jsou shodné: $|\\angle DAC|=|\\angle DCA|=73^\\circ$.','$\\delta=180^\\circ-2\\cdot 73^\\circ=34^\\circ$.'},
  'B) $34^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
