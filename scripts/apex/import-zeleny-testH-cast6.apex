String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'Zelený H12 – plášť tělesa z kruhových výsečí',
  new List<String>{'Na obrázku je podstava tělesa složená ze dvou do sebe vnořených soustředných kruhových výsečí. Plášť tělesa je kolmý k jeho podstavě a je vysoký $10$ cm.','Jaký je obsah pláště tohoto tělesa (bez obou podstav)? ($\\pi=3{,}14$)'},
  new List<String>{'A) $785$ cm²','B) $985$ cm²','C) $1613$ cm²','D) $5695$ cm²','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 420" font-family="sans-serif"> <circle cx="180" cy="200" r="130" fill="none" stroke="#000" stroke-width="2.5"/> <circle cx="180" cy="200" r="60" fill="none" stroke="#000" stroke-width="1.5" stroke-dasharray="5 5"/> <line x1="180" y1="70" x2="180" y2="140" stroke="#000" stroke-width="1"/> <line x1="40" y1="70" x2="40" y2="330" stroke="#444"/> <polygon points="40,70 36,78 44,78" fill="#444"/><polygon points="40,330 36,322 44,322" fill="#444"/> <text x="28" y="205" font-size="15" transform="rotate(-90 28 205)" text-anchor="middle">20 cm</text> <line x1="180" y1="52" x2="310" y2="52" stroke="#444"/> <polygon points="180,52 188,48 188,56" fill="#444"/><polygon points="310,52 302,48 302,56" fill="#444"/> <text x="245" y="44" font-size="15" text-anchor="middle">10 cm</text> <text x="316" y="300" font-size="15">90°</text> </svg>',
  'kruhove-vyseci.svg',
  'Podstava tělesa složená ze dvou soustředných kruhových výsečí s kótami 20 cm, 10 cm a úhlem 90 stupňů.',
  'Schematický nákres k úloze 12',
  new List<String>{'Plášť je kolmý k podstavě, proto $S=o\\cdot v$, kde $o$ je obvod podstavy a $v=10$ cm. Obvod hranice podstavy (vnější a vnitřní kruhové oblouky výsečí spolu se spojovacími úsečkami) je $98{,}5$ cm. Odtud $S=98{,}5\\cdot10=985$ cm².'},
  'B) $985$ cm²',
  2, 6, '4',
  new List<String>{'zs2','r9','stereometrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený H13 – dráha špičky minutové ručičky',
  new List<String>{'Určete, jakou dráhu oběhne špička $2$ metry dlouhé minutové ručičky věžních hodin od $5.50$ hodin ráno do $21.38$ hodin večer. Výsledek zaokrouhlete na celé centimetry. ($\\pi=3{,}14$)'},
  new List<String>{'A) $18\\,840$ cm','B) $19\\,443$ cm','C) $19\\,844$ cm','D) $19\\,845$ cm','E) jiný výsledek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Doba od $5.50$ do $21.38$ je $15$ h $48$ min $=948$ min $=15{,}8$ otáčky. Obvod kružnice $2\\pi r=2\\cdot3{,}14\\cdot2=12{,}56$ m. Dráha $15{,}8\\cdot12{,}56=198{,}448$ m $=19\\,844{,}8$ cm, po zaokrouhlení $19\\,845$ cm.'},
  'D) $19\\,845$ cm',
  2, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený H14 – součet obsahů dvou trojúhelníků',
  new List<String>{'Na obrázku jsou zvýrazněny dva pravoúhlé trojúhelníky, jejichž přepony $e$ a $f$ jsou stranami šedého obdélníku. Poměr délky odvěsen $a$ a $b$ stejně jako odvěsen $c$ a $d$ je $2:1$. Obsah šedého obdélníku je $50$ cm².','Jaký je součet obsahů obou vyznačených trojúhelníků?'},
  new List<String>{'A) $24$ cm²','B) $32$ cm²','C) $36$ cm²','D) $50$ cm²','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 400" font-family="sans-serif"> <polygon points="90,180 210,340 290,280 170,120" fill="#c9c9c9" stroke="#000" stroke-width="1.5"/> <polygon points="90,340 210,340 90,180" fill="#ffffff" stroke="#000" stroke-width="2"/> <polygon points="90,120 170,120 90,180" fill="#ffffff" stroke="#000" stroke-width="2"/> <line x1="90" y1="340" x2="90" y2="120" stroke="#000" stroke-width="1"/> <text x="74" y="270" font-size="17" font-style="italic">a</text> <text x="74" y="156" font-size="17" font-style="italic">d</text> <text x="122" y="112" font-size="17" font-style="italic">b</text> <text x="140" y="158" font-size="17" font-style="italic">f</text> <text x="166" y="262" font-size="17" font-style="italic">e</text> <text x="150" y="358" font-size="17" font-style="italic">c</text> </svg>',
  'obdelnik-trojuhelniky.svg',
  'Šedý obdélník se stranami e a f, k jehož přeponám jsou přiléhají dva pravoúhlé trojúhelníky s odvěsnami a, b, c, d.',
  'Schematický nákres k úloze 14',
  new List<String>{'Oba trojúhelníky jsou podobné s poměrem $2:1$, proto i přepony $e:f=2:1$. Z $e\\cdot f=50$ cm² plyne $f=5$ cm a $e=10$ cm. Trojúhelníky jsou pravoúhlé s odvěsnami v poměru $4:3$: menší má odvěsny $3$ cm a $4$ cm (obsah $6$ cm²), větší $6$ cm a $8$ cm (obsah $24$ cm²). Součet $6+24=30$ cm².'},
  'E) jiný výsledek ($30$ cm²)',
  2, 6, '4',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
