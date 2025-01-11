package ru.hse.random.walk

import android.app.Application;

import com.yandex.mapkit.MapKitFactory;

class MainApplication: Application() {
  override fun onCreate() {
    super.onCreate()
    MapKitFactory.setApiKey(YANDEX_MAP_API_KEY) // Your generated API key
  }
}